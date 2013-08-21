window.RestaurantModalController = ($scope, TagDAO) ->

  $scope.voteOnTag = (tag) ->
    TagDAO.vote(tag)