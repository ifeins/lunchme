angular.module('DAO', []).factory('RestaurantDAO', ($http, $q) ->
  fetchRequest = $http.get('fixtures/restaurants.json')

  @all = ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      restaurants = _.map(data, (restaurantData) -> new Restaurant(restaurantData))
      dfd.resolve(restaurants)
    )
    dfd.promise

  @find = (id) ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      restaurantData = _.find(data, (currentRestaurantData) -> currentRestaurantData.id == id)
      if (restaurantData)
        dfd.resolve(new Restaurant(restaurantData))
      else
        dfd.reject()
    )
    dfd.promise

  @
).factory('VoteDAO', ($http, $q, RestaurantDAO) ->

  fetchRequest = $http.get('fixtures/votes.json')

  @all = ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      votes = _.map(data, (voteData) -> new Vote(Restaurant, voteData))
      dfd.resolve(votes)
    )
    dfd.promise


  @find = (id) ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      voteData = _.find(data, (currentVoteData) -> currentVoteData.id == id)
      if (voteData)
        dfd.resolve(new Vote(Restaurant, voteData))
      else
        dfd.reject()
    )
    dfd.promise

  @
).factory('LunchDAO', ($http, $q) ->

  fetchRequest = $http.get('fixtures/lunches.json')

  @all = ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      dfd.resolve(data)
    )
    dfd.promise

  @today = ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      dfd.resolve(_.last(data))
    )
    dfd.promise

  @
)