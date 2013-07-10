window.HeaderController = ($scope, $http) ->

  $scope.user = User.current

  $scope.signIn = ->
    Browser.redirectTo(Routes.sign_in_path('google_oauth2'))

  $scope.signOut = ->
    $http.delete(Routes.session_path()).success(->
      Browser.refresh()
    )