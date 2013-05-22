window.LunchController = ($scope, LunchDAO) ->
  $scope.lunch = LunchDAO.today()
