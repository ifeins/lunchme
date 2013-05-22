window.SearchRestaurantsController = ($scope, RestaurantDAO) ->

  $scope.restaurants = RestaurantDAO.all()