angular.module('Lunchtime').directive 'selectize', ($timeout, $parse) ->
  restrict: 'AE'
  link: (scope, el, attrs) ->
    configureSelectize(el, scope, attrs)

    $timeout(->
      loadFn = $parse(attrs.selectizeLoad)(scope)
      el[0].selectize.load(loadFn)
    )

configureSelectize = ($el, scope, attrs) ->
  $el.selectize scope.$eval(attrs.selectize)

