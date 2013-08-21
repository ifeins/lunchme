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
    $http.get('restaurants.json').success((list) ->
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
    return null unless userData

    user = users[userData.id]
    unless user
      user = User.parse(userData)
      users[user.id] = user

    user

  @

).factory('VoteDAO', ($http) ->

  @create = (vote) ->
    vote.lunch.addVote vote
    $http.post("lunches/#{vote.lunch.id}/votes.json", vote.toJSON()).success((response) ->
      vote.id = response.id
    ).error(->
      # in case of failure we revert the addition
      vote.lunch.removeVote vote
    )

  @destroy = (vote) ->
    vote.lunch.removeVote vote
    $http.delete("lunches/#{vote.lunch.id}/votes/#{vote.id}.json").error(->
      vote.lunch.addVote vote
    )

  @

).factory('LunchDAO', ($http, $q, RestaurantDAO, UserDAO) ->

  @today = ->
    dfd = $q.defer()

    RestaurantDAO.load().then( ->
      $http.get('lunches/1.json').success((data) ->
        lunch = new Lunch(data.id, data.date)
        lunch.votes = _createVotes(lunch, data.votes, RestaurantDAO, UserDAO)
        dfd.resolve(lunch)
      )
    )

    dfd.promise

  @
).factory('TagDAO', ($http) ->

  @vote = (tag) ->
    tag.increment()

    $http.put("restaurants/#{tag.restaurant.id}/tags/#{tag.id}/vote.json", tag.toJSON()).error(->
      tag.decrement() # revert operation
    )

  @

)

