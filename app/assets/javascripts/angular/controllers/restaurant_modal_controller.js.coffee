angular.module('Lunchtime').controller('RestaurantModalController', ($scope, $http, TagDAO, RestaurantDAO) ->

  $scope.user = User.current

  $scope.voteOnTag = (tag) ->
    if tag.userVotedFor(User.current)
      if tag.quantity == 1
        TagDAO.destroy(tag)
      else
        TagDAO.unvote(tag)
    else
      TagDAO.vote(tag)

  $scope.addTag = (restaurant, tagName) ->
    tag = new Tag(name: tagName, restaurant: restaurant)
    TagDAO.create(tag).then(->
      $scope.availableTags = _.without($scope.availableTags, tag.name)
    )

  $scope.availableTags = []
  RestaurantDAO.availableTags($scope.restaurant).then((tags) -> $scope.availableTags = tags)
)
