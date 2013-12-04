angular.module('Lunchtime').directive('onKeyUp', ->
  (scope, el, attrs) ->
    applyKeyUp = -> scope.$apply(attrs.onKeyUp)

    allowedKeys = scope.$eval(attrs.keys)

    el.bind('keyup', (event) ->
      if (!allowedKeys || allowedKeys.length == 0)
        applyKeyUp()
      else
        angular.forEach(allowedKeys, (key) ->
          applyKeyUp() if key == event.which
        )
    )
)