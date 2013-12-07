angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal, OfficeDAO) ->

  $scope.offices = []

  $scope.submit = ->
    data = {area: {name: $scope.selectedArea.name}}
    $http.put("#{Routes.session_path()}.json", data).success(->
      $modal('hide')
    )

  OfficeDAO.load().then(->
    $scope.offices = OfficeDAO.all()
  )
)