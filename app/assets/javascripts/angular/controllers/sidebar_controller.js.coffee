window.SidebarController = ($scope, LunchDAO) ->

  $scope.lunch = []
  LunchDAO.yesterday().then((lunch) ->
    $scope.lunch = lunch
  )

  $scope.restaurants = ->
    return [] if _.isEmpty($scope.lunch)

    restaurants = $scope.lunch.userRestaurants(User.current)
    $scope.canShow = true
    restaurants

