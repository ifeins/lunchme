angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.autocompleteOptions = {
    componentRestrictions:
      country: 'il'
  }

  $scope.newOffice = {
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

    if $scope.selectedOfficeId
      data.user = {office_id: $scope.selectedOfficeId}
    else
      office = officeFromScopeModel($scope.newOffice)
      data.user = {office_attributes: office.toJSON()}

    $http.put("#{Routes.session_path()}.json", data).success(->
      $modal('hide')
    )

  $scope.officeSelected = ->
    $scope.newOffice.name = ''
    $scope.newOffice.address = ''

    $scope.signUpForm.officeName.$setValidity('minlength', true)
    $scope.signUpForm.officeAddress.$setValidity('completeAddressRequired', true)
    $scope.signUpForm.$setPristine()

  officeFromScopeModel = (model) ->
    location = Location.fromGooglePlace(model.address)

    new Office(
      name: model.name
      location: location
    )

)