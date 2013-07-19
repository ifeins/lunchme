_createVotes = (lunch, votes, RestaurantDAO) ->
  _.map(votes, (voteData) ->
    user = new User(voteData.user)
    restaurant = RestaurantDAO.find(voteData.restaurantId)
    new Vote(lunch, user, restaurant)
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
        lunch = new Lunch(data.date)
        lunch.votes = _createVotes(lunch, data.votes, RestaurantDAO)
        dfd.resolve(lunch)
      )
    )

    dfd.promise

  @
)

