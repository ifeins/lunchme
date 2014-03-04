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

  selectionHandler = -> scope.$apply(attrs.bsTypeaheadHandler) if attrs.bsTypeaheadHandler
  engine = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.whitespace
    queryTokenizer: Bloodhound.tokenizers.whitespace
    local: value
  )
  engine.initialize()

  el.typeahead('destroy')
  el.typeahead(
    {
      autoselect: true
    },
    {
      name: null # we don't set a name for the dataset as we don't want it to be cached
      displayKey: (datum) -> datum
      source: engine.ttAdapter()
    }
  )
  el.on('typeahead:autocompleted', (obj, datum) ->
    ngModel.$setViewValue(datum)
    selectionHandler() if selectionHandler
  )
  el.on('typeahead:selected', (obj, datum) ->
    ngModel.$setViewValue(datum)
    selectionHandler() if selectionHandler
  )
  el.on('typeahead:opened', ->
    safeApply(scope, -> scope["#{attrs.bsTypeaheadId}Opened"] = true)
  )
  el.on('typeahead:closed', ->
    safeApply(scope, -> scope["#{attrs.bsTypeaheadId}Opened"] = false)
  )


