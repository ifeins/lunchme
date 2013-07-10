window.HeaderController = ($scope, $http, $modal) ->

  $scope.user = User.current

  $scope.signIn = ->
    Browser.redirectTo(Routes.sign_in_path('google_oauth2'))
    # $modal(template: 'components/sign_in_modal', className: 'sign-in-modal')

  $scope.signOut = ->
    $http.delete(Routes.session_path()).success(->
      Browser.refresh()
    )