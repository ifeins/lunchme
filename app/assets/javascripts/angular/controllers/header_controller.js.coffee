window.HeaderController = ($scope, $modal) ->

  $scope.signIn = ->
    Browser.redirectTo(Routes.sign_in_path('google_oauth2'))
#    $modal(template: 'components/sign_in_modal', className: 'sign-in-modal')