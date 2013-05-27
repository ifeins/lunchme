window.LunchPageController = ($scope, lunch, RestaurantDAO) ->
  $scope.lunch = lunch
  $scope.restaurants = RestaurantDAO.all()
