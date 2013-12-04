angular.module('Lunchtime').controller('FillDetailsController', ($scope, $http, $modal) ->

  $scope.areas = [{id: 1, name: 'Tel Aviv'}, {id: 2, name: 'Herzliya Pituch'}, {id: 3, name: 'Ramat Ha-Hayal'}]
  $scope.selectedArea = $scope.areas[0]

  $scope.submit = ->
    data = {area: {name: $scope.selectedArea.name}}
    $http.put("#{Routes.session_path()}.json", data).success(->
      $modal('hide')
    )
)