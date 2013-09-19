ENTER_KEY_CODE = 13

Lunchtime.directive('onEnter', ->
  (scope, el, attrs) ->
    applyEnter = -> scope.$apply(attrs.onEnter)

    el.bind('keyup', (event) ->
      applyEnter() if event.which == ENTER_KEY_CODE
    )
)