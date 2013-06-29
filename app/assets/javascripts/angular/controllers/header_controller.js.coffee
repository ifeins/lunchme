window.HeaderController = ($scope, $modal) ->

  $scope.showSignIn = ->
    $modal(template: 'components/sign_in_modal', className: 'sign-in-modal')