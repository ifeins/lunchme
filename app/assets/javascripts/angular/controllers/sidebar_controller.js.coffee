angular.module('Lunchtime').controller('SidebarController', ($scope, $timeout, LunchDAO, RestaurantDAO, VisitDAO, TagDAO, SurveyDAO) ->

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

    restaurants

  $scope.visitRestaurant = (restaurant) ->
    restaurant = RestaurantDAO.findByName(restaurant) if _.isString(restaurant)
    visit = $scope.lunch.userVisit(User.current)
    if visit
      VisitDAO.update(visit, restaurant)
    else
      visit = new Visit($scope.lunch, User.current, restaurant)
      VisitDAO.create(visit)

  $scope.hasVisitedRestaurant = (restaurant = null) ->
    if restaurant
      $scope.lunch.hasVisited?(restaurant)
    else
      $scope.lunch.userVisit?(User.current)?

  $scope.visitedRestaurant = ->
    $scope.lunch.userVisit?(User.current)?.restaurant

  $scope.voteOnTag = (tag) ->
    TagDAO.vote(tag) unless tag.userVotedFor(User.current)

  $scope.addTag = (restaurant, tagName) ->
    tag = new Tag(name: tagName, restaurant: restaurant)
    TagDAO.create(tag).then(->
      $scope.availableTags = _.without($scope.availableTags, tag.name)
    )

  $scope.done = ->
    $scope.surveyCompleted = true

    # create the survey after a timeout so the message will have enough time to appear
    $timeout(
      ->
        survey = new Survey('completed', User.current, $scope.lunch)
        SurveyDAO.create(survey).then(null, -> $scope.surveyCompleted = false)
      1000
    )

  $scope.allRestaurants = _.pluck(RestaurantDAO.all(), 'name')
  $scope.availableTags = []
  $scope.$watch('visitedRestaurant()', (newValue, oldValue) ->
    if newValue != oldValue
      RestaurantDAO.availableTags(newValue).then((tags) -> $scope.availableTags = tags)
  )
)




