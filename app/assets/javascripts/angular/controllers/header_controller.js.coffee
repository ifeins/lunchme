angular.module('Lunchtime').controller('HeaderController', ($scope, $http) ->

  $scope.user = User.current

  $scope.signIn = ->
    User.signIn()

  $scope.signOut = ->
    $http.delete(Routes.session_path()).success(->
      Browser.refresh()
    )
)