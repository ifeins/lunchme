window.SidebarController = ($scope, LunchDAO, RestaurantDAO, VisitDAO) ->

  $scope.lunch = []
  LunchDAO.yesterday().then((lunch) ->
    $scope.lunch = lunch
  )

  $scope.restaurants = ->
    return [] if _.isEmpty($scope.lunch)

    restaurants = $scope.lunch.userVotedRestaurants(User.current)
    visit = $scope.lunch.userVisit(User.current)
    if visit and not _.contains(restaurants, visit.restaurant)
      restaurants.push visit.restaurant

    $scope.canShow = true
    restaurants

  $scope.visited = (restaurant) ->
    restaurant = RestaurantDAO.findByName(restaurant) if _.isString(restaurant)
    visit = $scope.lunch.userVisit(User.current)
    if visit
      VisitDAO.update(visit, restaurant)
    else
      visit = new Visit($scope.lunch, User.current, restaurant)
      VisitDAO.create(visit)

  $scope.hasVisited = (restaurant) ->
    $scope.lunch.hasVisited?(restaurant)

  $scope.visitedRestaurant = ->
    $scope.lunch.userVisit?(User.current)?.restaurant


  $scope.allRestaurants = _.pluck(RestaurantDAO.all(), 'name')

