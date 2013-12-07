angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.offices = [name: 'Select office']
  $scope.selectedOffice = $scope.offices[0]

  $scope.submit = ->
    data = {area: {name: $scope.selectedArea.name}}
    $http.put("#{Routes.session_path()}.json", data).success(->
      $modal('hide')
    )

  OfficeDAO.load().then(->
    $scope.offices = $scope.offices.concat(OfficeDAO.all())
  )
)