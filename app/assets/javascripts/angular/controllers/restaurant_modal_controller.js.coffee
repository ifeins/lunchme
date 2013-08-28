window.RestaurantModalController = ($scope, $http, TagDAO, RestaurantDAO) ->

  $scope.voteOnTag = (tag) ->
    TagDAO.vote(tag)

  $scope.addTag = (restaurant, tagName) ->
    tag = new Tag(name: tagName, restaurant: restaurant)
    TagDAO.create(tag)

  $scope.availableTags = []

  RestaurantDAO.availableTags($scope.restaurant).then((tags) -> $scope.availableTags = tags)

