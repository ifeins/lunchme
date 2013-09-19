window.SidebarController = ($scope, LunchDAO, RestaurantDAO, VisitDAO) ->

  $scope.lunch = []
  LunchDAO.yesterday().then((lunch) ->
    $scope.lunch = lunch
  )

  $scope.restaurants = ->
    return [] if _.isEmpty($scope.lunch)

    restaurants = $scope.lunch.userRestaurants(User.current)
    $scope.canShow = true
    restaurants

  $scope.visited = (restaurant) ->
    visit = new Visit($scope.lunch, User.current, restaurant)
    VisitDAO.create(visit)


  $scope.allRestaurants = _.pluck(RestaurantDAO.all(), 'name')

