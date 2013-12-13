angular.module('Lunchtime').directive('gglPlacesAutocomplete', ($parse) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, element, attrs, model) ->
    scope.$watch(attrs.gglPlacesAutocomplete, (opts) ->
      autocomplete = new google.maps.places.Autocomplete(element[0], opts)
      google.maps.event.addListener(autocomplete, 'place_changed', ->
        scope.$apply(->
          model.$setViewValue(autocomplete.getPlace())
        )
      )
    )
)