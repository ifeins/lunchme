Lunchtime.directive('stopEvent', ->
  restrict: 'A',
  link: (scope, element, attr) ->
    element.bind(attr.stopEvent, (e) -> e.stopPropagation())
)