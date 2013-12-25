angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.autocompleteOptions = {
    componentRestrictions:
      country: 'il'
  }

  $scope.office = {
    id: null
    name: ''
    address: ''
  }

  $scope.loadOffices = (callback) ->
    OfficeDAO.load().then(->
      offices = _.map(OfficeDAO.all(), (office) -> {value: office.id, text: office.name})
      callback(offices)
    )

  $scope.submit = ->
    data = {user: null}

    if $scope.office.id
      data.user = {office_id: $scope.office.id}
    else
      office = officeFromScopeModel($scope.office)
      data.user = {office_attributes: office.toJSON()}

    $http.put("#{Routes.session_path()}.json", data).success(->
      # reload the browser so the restaurants displayed will be filtered by the office's location
      window.location.reload()
    )

  $scope.officeSelected = ->
    $scope.office.name = ''
    $scope.office.address = ''

    $scope.signUpForm.officeName.$setValidity('minlength', true)
    $scope.signUpForm.officeAddress.$setValidity('completeAddressRequired', true)
    $scope.signUpForm.$setPristine()

  $scope.clearOfficeSelection = ->
    $scope.office.id = null

  officeFromScopeModel = (model) ->
    location = Location.fromGooglePlace(model.address)

    new Office(
      name: model.name
      location: location
    )

)