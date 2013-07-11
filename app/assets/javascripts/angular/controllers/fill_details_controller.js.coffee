window.FillDetailsController = ($scope, $http) ->

  $scope.areas = [{id: 1, name: 'Tel Aviv'}, {id: 2, name: 'Herzliya Pituch'}, {id: 3, name: 'Ramat Ha-Hayal'}]
  $scope.selectedArea = $scope.areas[0]

  $scope.submit = ->
    console.log "selected area is: #{$scope.selectedArea.name}"
