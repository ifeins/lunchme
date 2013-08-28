Lunchtime.directive('bsTypeahead', ($parse) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, el, attrs, ngModel) ->
    getter = $parse(attrs.bsTypeahead)
    value = getter(scope)

    scope.$watch(attrs.bsTypeahead, (newValue, oldValue) ->
      if newValue != oldValue
        value = newValue

        el.typeahead('destroy')
        el.typeahead(local: value) # we don't set a name for the dataset as we don't want it to be cached
        el.bind('typeahead:autocompleted', (obj, datum) ->
          ngModel.$setViewValue(datum.value)
        )
    )

)