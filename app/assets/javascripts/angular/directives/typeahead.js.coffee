angular.module('Lunchtime').directive('bsTypeahead', ($parse) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, el, attrs, ngModel) ->
    configureTypeahead($parse, scope, el, attrs, ngModel)

    scope.$watch(attrs.bsTypeahead, (newValue, oldValue) ->
      if newValue != oldValue
        configureTypeahead($parse, scope, el, attrs, ngModel)
    )

)

configureTypeahead = ($parse, scope, el, attrs, ngModel) ->
  value = $parse(attrs.bsTypeahead)(scope)
  return unless value

  el.typeahead('destroy')
  el.typeahead(local: value) # we don't set a name for the dataset as we don't want it to be cached
  el.on('typeahead:autocompleted', (obj, datum) ->
    ngModel.$setViewValue(datum.value)
  )
  el.on('typeahead:suggestions-rendered', ->
    safeApply(scope, -> scope["#{attrs.bsTypeaheadId}Opened"] = true)
  )
  el.on('typeahead:suggestions-cleared', ->
    safeApply(scope, -> scope["#{attrs.bsTypeaheadId}Opened"] = false)
  )

  # need both blur and focousout for this to work
  el.blur(-> safeApply(scope, -> scope["#{attrs.bsTypeaheadId}Opened"] = false))
  el.focusout(-> safeApply(scope, -> scope["#{attrs.bsTypeaheadId}Opened"] = false))


