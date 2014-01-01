angular.module('Lunchtime').controller('RestaurantModalController', ($scope, $http, TagDAO, RestaurantDAO) ->

  $scope.user = User.current

  $scope.voteOnTag = (tag) ->
    TagDAO.vote(tag) unless tag.userVotedFor(User.current)

  $scope.addTag = (restaurant, tagName) ->
    tag = new Tag(name: tagName, restaurant: restaurant)
    TagDAO.create(tag).then(->
      $scope.availableTags = _.without($scope.availableTags, tag.name)
    )

  $scope.availableTags = []
  RestaurantDAO.availableTags($scope.restaurant).then((tags) -> $scope.availableTags = tags)
)
