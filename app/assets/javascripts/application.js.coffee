#= require jquery
#= require jquery_ujs
#= require underscore
#= require hamlcoffee
#= require string
#= require js-routes
#= require browser
#= require utils
#= require_tree ../templates
#= require angular/angular
#= require angular/angular-resource
#= require_tree ./angular
#= require_self

angular.module('Lunchme', ['DAO', 'UI']).config(($routeProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'

  $httpProvider.defaults.transformResponse.push((value) ->
    Utils.camelCaseObject(value) if value
  )

  $routeProvider.when('/', controller: 'LunchPageController', template: JST['pages/lunch_page'](), resolve: {
    lunch: (LunchDAO) -> LunchDAO.today()
  })
)


