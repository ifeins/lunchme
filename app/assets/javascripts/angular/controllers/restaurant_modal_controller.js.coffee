window.RestaurantModalController = ($scope, TagDAO) ->

  $scope.voteOnTag = (tag) ->
    TagDAO.vote(tag)

  $scope.addTag = (restaurant, tagName) ->
    tag = new Tag(name: tagName, restaurant: restaurant)
    TagDAO.create(tag)