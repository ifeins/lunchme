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

