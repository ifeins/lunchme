angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.officesLoaded = false
  $scope.offices = []
  $scope.selectedOffice = $scope.offices[0]

  $scope.submit = ->
    office = if $scope.selectedOffice then $scope.selectedOffice else new Office($scope.newOffice)
    data = {office: office.toJSON()}
    $http.put("#{Routes.session_path()}.json", data).success(->
      $modal('hide')
    )

  OfficeDAO.load().then(->
    $scope.offices = $scope.offices.concat(OfficeDAO.all())
    $scope.officesLoaded = true
  )
)