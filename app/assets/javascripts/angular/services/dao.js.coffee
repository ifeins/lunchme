_createVotes = (data, RestaurantDAO) ->
  _.map(data.votes, (voteData) ->
    user = new User(voteData.user)
    restaurant = RestaurantDAO.find(voteData.restaurantId)
    new Vote(user, restaurant)
  )

angular.module('DAO', ['ngResource']).factory('RestaurantDAO', ($resource, $q) ->

  dao = $resource('restaurants/:id')
  restaurants = {}

  @load = ->
    dfd = $q.defer()
    dao.query((list) ->
      _.each(list, (data) -> restaurants[data.id] = new Restaurant(data))
      dfd.resolve()
    )
    dfd.promise

  @all = ->
    _.values(restaurants)

  @find = (id) ->
    restaurants[id]

  @
).factory('LunchDAO', ($resource, $q, RestaurantDAO) ->

  dao = $resource('lunches/:id')

  @today = ->
    dfd = $q.defer()

    RestaurantDAO.load().then( ->
      dao.get(id: 1, (data) ->
        votes = _createVotes(data, RestaurantDAO)
        lunch = new Lunch(data.date, votes)
        dfd.resolve(lunch)
      )
    )

    dfd.promise

  @
)

