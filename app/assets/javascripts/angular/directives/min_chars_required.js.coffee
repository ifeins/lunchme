angular.module('Lunchtime').directive('minCharsRequired', ->
  require: 'ngModel'
  link: (scope, el, attrs, model) ->
    model.$parsers.unshift((viewValue) ->
      if viewValue.length >= attrs.minCharsRequired
        model.$setValidity('minCharsRequired', true)
        viewValue
      else
        model.$setValidity('minCharsRequired', false)
        undefined
    )
)