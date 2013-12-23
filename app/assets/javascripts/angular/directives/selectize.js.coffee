angular.module('Lunchtime').directive 'selectize', ($timeout, $parse) ->
  restrict: 'AE'
  link: (scope, el, attrs) ->
    configureSelectize(el, scope, attrs)

    $timeout(->
      loadFn = $parse(attrs.selectizeLoad)(scope)
      el[0].selectize.load(loadFn)
    )

configureSelectize = ($el, scope, attrs) ->
  options = scope.$eval(attrs.selectize)
  if options.onChange
    methodName = options.onChange
    options.onChange = (value) ->
      method = scope.$eval(methodName)
      method(value)

  $el.selectize options

