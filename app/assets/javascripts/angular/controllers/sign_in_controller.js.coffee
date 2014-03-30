angular.module('Lunchtime').controller('SignInController', ($scope, $modal) ->

  $scope.submit = ->
    User.signIn()
)

