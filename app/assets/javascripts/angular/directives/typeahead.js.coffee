Lunchtime.directive('bsTypeahead', ($parse) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, el, attrs, ngModel) ->
    getter = $parse(attrs.bsTypeahead)
    value = getter(scope)

    scope.$watch(attrs.bsTypeahead, (newValue, oldValue) ->
      if newValue != oldValue
        value = newValue
        el.typeahead(
          name: 'tags'
          local: value
        )
        el.bind('typeahead:autocompleted', (obj, datum) ->
          scope.$apply(ngModel.$setViewValue(datum.value))
        )
    )

)