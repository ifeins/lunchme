window.LunchPageController = ($scope, lunch, RestaurantDAO) ->
  $scope.lunch = lunch
  $scope.restaurants = RestaurantDAO.all()
  $scope.query = ''

  $scope.restaurantSearch = (restaurant) ->
    matchTerms = _.union([restaurant.name, restaurant.category], _.map(restaurant.tags, (tag) -> tag.name))
    _.any(matchTerms, (term) -> term.toLowerCase().indexOf($scope.query) != -1)