angular.module('Lunchtime').directive('completeAddressRequired', ->
  require: 'ngModel'
  link: (scope, el, attrs, model) ->
    model.$parsers.unshift((viewValue) ->
      location = Location.fromGooglePlace(viewValue)
      if _.isEmpty(location) or _.isEmpty(location.street) or _.isEmpty(location.city)
        model.$setValidity('completeAddressRequired', false)
        undefined
      else
        model.$setValidity('completeAddressRequired', true)
        viewValue
    )
)