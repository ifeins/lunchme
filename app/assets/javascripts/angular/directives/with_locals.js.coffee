# ported to coffescript from http://stackoverflow.com/a/17876761/1082326
angular.module('Lunchtime').directive('withLocals', ->
  restrict: 'A'
  link: (scope, el, attributes) ->
    localsMap = {}
    for attr of attributes
      if attributes.hasOwnProperty(attr) and /^locals[A-Z0-9]/.test(attr)
        localKey = attr.slice(6)
        localKey = localKey[0].toLowerCase() + localKey.slice(1)
        localsMap[localKey] = attributes[attr]

    for localKey of localsMap
      scope.$watch(localsMap[localKey], (newValue, oldValue) ->
        scope[localKey] = newValue if newValue != oldValue
      )
)