angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.autocompleteOptions = {
    componentRestrictions:
      country: 'il'
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
      data.user = {office_attributes: officeFromScopeModel($scope.newOffice).toJSON()}

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


)