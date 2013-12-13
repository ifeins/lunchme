angular.module('Lunchtime').directive('minChars', ->
  require: 'ngModel'
  link: (scope, el, attrs, model) ->
    model.$parsers.unshift((viewValue) ->
      if viewValue.length >= 3
        model.$setValidity('minChars', true)
        viewValue
      else
        model.$setValidity('minChars', false)
        undefined
    )
)