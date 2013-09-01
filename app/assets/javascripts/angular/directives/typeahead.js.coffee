Lunchtime.directive('bsTypeahead', ($parse) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, el, attrs, ngModel) ->
    scope.$watch(attrs.bsTypeahead, (newValue, oldValue) ->
      if newValue != oldValue
        value = newValue

        el.typeahead('destroy')
        el.typeahead(local: value) # we don't set a name for the dataset as we don't want it to be cached
        el.on('typeahead:autocompleted', (obj, datum) ->
          ngModel.$setViewValue(datum.value)
        )
        el.on('typeahead:dropdown-opened', ->
          scope.$apply(-> scope["#{attrs.bsTypeaheadId}Opened"] = true)
        )
        el.on('typeahead:dropdown-closed', ->
          scope.$apply(-> scope["#{attrs.bsTypeaheadId}Opened"] = false)
        )
    )

)