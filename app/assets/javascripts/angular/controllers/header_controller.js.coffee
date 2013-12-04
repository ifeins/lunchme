angular.module('Lunchtime').controller('HeaderController', ($scope, $http) ->

  $scope.user = User.current

  $scope.signIn = ->
    Browser.redirectTo(Routes.sign_in_path('facebook', internal_redirect_url: window.location.toString()))

  $scope.signOut = ->
    $http.delete(Routes.session_path()).success(->
      Browser.refresh()
    )
)