angular.module('Lunchtime').directive('minCharsRequired', ->
  require: 'ngModel'
  link: (scope, el, attrs, model) ->
    model.$parsers.unshift((viewValue) ->
      if viewValue.length >= attrs.minCharsRequired
        model.$setValidity('minChars', true)
        viewValue
      else
        model.$setValidity('minChars', false)
        undefined
    )
)