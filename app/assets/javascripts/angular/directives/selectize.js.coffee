angular.module('Lunchtime').directive 'selectize', ($timeout) ->
  restrict: 'AE'
  link: (scope, el, attrs) ->
    scope.$watch(attrs.selectizeOn, (newValue, oldValue) ->
      $timeout(->
        configureSelectize($(el), scope, attrs) if newValue and newValue != oldValue
      )
    )

configureSelectize = ($el, scope, attrs) ->
  $el.selectize scope.$eval(attrs.selectize)

