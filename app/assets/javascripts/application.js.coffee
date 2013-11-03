#= require jquery
#= require jquery_ujs
#= require underscore
#= require hamlcoffee
#= require string
#= require js-routes
#= require browser
#= require utils
#= require typeahead
#= require_tree ../templates
#= require angular/angular
#= require angular/angular-resource
#= require_self
#= require_tree ./angular

window.safeApply = (scope, fn) ->
  if (scope.$$phase || scope.$root.$$phase) then fn() else scope.$apply(fn)

window.Lunchtime = angular.module('Lunchtime', ['DAO', 'UI'])

Lunchtime.config(($routeProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'

  $httpProvider.defaults.transformResponse.push((value, headers) ->
    contentType = headers('content-type')

    if contentType and contentType.indexOf('application/json') != -1
      if value then Utils.camelCaseObject(value) else value
    else
      value
  )

  $routeProvider.when('/',
    controller: 'LunchPageController'
    template: JST['pages/lunch_page']()
    resolve:
      lunch: (LunchDAO, $location) ->
        $location.path('lunches/today')
        LunchDAO.today()
  ).when('/lunches/:date',
    controller: 'LunchPageController'
    template: JST['pages/lunch_page']()
    resolve:
      lunch: ($route, LunchDAO) -> LunchDAO.findByDate($route.current.params.date)
  )
)


