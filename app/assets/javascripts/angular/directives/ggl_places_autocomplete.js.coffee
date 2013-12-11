angular.module('Lunchtime').directive('gglPlacesAutocomplete', ($parse) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, element, attrs, model) ->
    opts = $parse(attrs.gglPlacesAutocomplete)
    autocomplete = new google.maps.places.Autocomplete(element[0], opts)
    google.maps.event.addListener(autocomplete, 'place_changed', ->
      scope.$apply(->
        model.$setViewValue(autocomplete.getPlace())
      )
    )

)