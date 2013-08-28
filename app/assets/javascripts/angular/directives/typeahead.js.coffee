Lunchtime.directive('bsTypeahead', ($parse) ->
  (scope, el, attrs) ->
    getter = $parse(attrs.bsTypeahead)
    value = getter(scope)

    scope.$watch(attrs.bsTypeahead, (newValue, oldValue) ->
      if newValue != oldValue
        value = newValue
        el.typeahead(
          name: 'tags'
          local: value
        )
    )

)