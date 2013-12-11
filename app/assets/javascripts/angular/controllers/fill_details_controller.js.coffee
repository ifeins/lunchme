angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.officesLoaded = false
  $scope.offices = []
  $scope.selectedOffice = $scope.offices[0]

  $scope.autocompleteOptions = {
    componentRestrictions:
      country: 'il'
  }

  $scope.submit = ->
    office = if $scope.selectedOffice then $scope.selectedOffice else officeFromScopeModel($scope.newOffice)
    data = {office: office.toJSON()}
    $http.put("#{Routes.session_path()}.json", data).success(->
      $modal('hide')
    )

  officeFromScopeModel = (model) ->
    addressComps = model.address.address_components
    coordinates = model.address.geometry.location

    new Office(
      name: model.name
      location:
        street: "#{addressComps[1].long_name} #{addressComps[0].long_name}"
        city: addressComps[2].long_name
        latitude: coordinates.pb or coordinates.nb
        longitude: coordinates.qb or coordinates.ob
    )

  OfficeDAO.load().then(->
    $scope.offices = $scope.offices.concat(OfficeDAO.all())
    $scope.officesLoaded = true
  )
)