_createVotes = (data, RestaurantDAO) ->
  _.map(data.votes, (voteData) ->
    user = _findUser(data.users, voteData.userId)
    restaurant = RestaurantDAO.find(voteData.restaurantId)
    vote = new Vote(user, restaurant)
    restaurant.addVote(vote)
    vote
  )

_findUser = (list = [], id) ->
  data = _.findWhere(list, id: id)
  if data then new User(data) else null

angular.module('DAO', []).factory('RestaurantDAO', ($http, $q) ->
  fetchRequest = $http.get('fixtures/restaurants.json')

  restaurants = {}

  @load = ->
    dfd = $q.defer()
    fetchRequest.success((list) ->
      _.each(list, (data) -> restaurants[data.id] = new Restaurant(data))
      dfd.resolve()
    )
    dfd.promise

  @find = (id) ->
    restaurants[id]

  @all = ->
    _.values(restaurants)

  @
).factory('LunchDAO', ($http, $q, RestaurantDAO) ->

  fetchRequest = $http.get('fixtures/lunch.json')

  @today = ->
    dfd = $q.defer()

    RestaurantDAO.load().then( ->
      fetchRequest.success((data) ->
        votes = _createVotes(data, RestaurantDAO)
        lunch = new Lunch(data.date, votes)
        dfd.resolve(lunch)
      )
    )
    dfd.promise

  @
)

