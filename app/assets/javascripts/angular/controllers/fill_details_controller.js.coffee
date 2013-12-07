angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.officesLoaded = false
  $scope.offices = [name: 'Select office']
  $scope.selectedOffice = $scope.offices[0]

  $scope.submit = ->
    data = {office: {name: $scope.selectedOffice.name}}
    $http.put("#{Routes.session_path()}.json", data).success(->
      $modal('hide')
    )

  OfficeDAO.load().then(->
    $scope.offices = $scope.offices.concat(OfficeDAO.all())
    $scope.officesLoaded = true
  )
)