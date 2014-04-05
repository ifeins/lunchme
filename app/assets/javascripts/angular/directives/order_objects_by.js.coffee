angular.module('Lunchtime').filter('orderObjectsBy', ->
  (objects, sortingFunction) ->
    sorted = []
    angular.forEach(objects, (object) ->
      sorted.push object
    )

    sorted.sort(sortingFunction)
    sorted
)