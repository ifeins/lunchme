_createVotes = (lunch, votes, RestaurantDAO, UserDAO) ->
  _.map(votes, (voteData) ->
    user = UserDAO.findOrInitializeById(voteData.user)
    restaurant = RestaurantDAO.find(voteData.restaurantId)
    vote = new Vote(lunch, user, restaurant)
    vote.id = voteData.id

    vote
  )

angular.module('DAO', []).factory('RestaurantDAO', ($http, $q) ->

  restaurants = {}

  @load = ->
    dfd = $q.defer()
    $http.get('restaurants').success((list) ->
      _.each(list, (data) -> restaurants[data.id] = new Restaurant(data))
      dfd.resolve()
    )
    dfd.promise

  @all = ->
    _.values(restaurants)

  @find = (id) ->
    restaurants[id]

  @
).factory('UserDAO', ->

  users = {}

  @findOrInitializeById = (userData) ->
    user = users[userData.id]
    unless user
      user = User.parse(userData)
      users[user.id] = user

    user

  @

).factory('VoteDAO', ($http) ->

  @create = (vote) ->
    $http.post("lunches/#{vote.lunch.id}/votes", vote).success((response) ->
      vote.id = response.id
      vote.lunch.addVote vote
    )

  @destroy = (vote) ->
    $http.delete("lunches/#{vote.lunch.id}/votes/#{vote.id}").success(->
      vote.lunch.removeVote vote
    )

  @

).factory('LunchDAO', ($http, $q, RestaurantDAO, UserDAO) ->

  @today = ->
    dfd = $q.defer()

    RestaurantDAO.load().then( ->
      $http.get('lunches/1').success((data) ->
        lunch = new Lunch(data.id, data.date)
        lunch.votes = _createVotes(lunch, data.votes, RestaurantDAO, UserDAO)
        dfd.resolve(lunch)
      )
    )

    dfd.promise

  @
)

