angular.module('DAO', []).factory('RestaurantDAO', ($http, $q) ->
  fetchRequest = $http.get('fixtures/restaurants.json')

  @all = ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      restaurants = _.map(data, (restaurantData) -> new Restaurant(restaurantData))
      dfd.resolve(restaurants)
    )
    dfd.promise

  @
).factory('LunchDAO', ($http, $q) ->

  fetchRequest = $http.get('fixtures/lunch.json')

  @today = ->
    dfd = $q.defer()
    fetchRequest.success((data) ->
      dfd.resolve(new Lunch(data))
    )
    dfd.promise

  @
)