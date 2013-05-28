#= require jquery
#= require jquery_ujs
#= require underscore
#= require hamlcoffee
#= require_tree ../templates
#= require angular
#= require_tree ./angular
#= require_self

angular.module('Lunchme', ['DAO']).config(($routeProvider) ->
  $routeProvider.when('/', controller: 'LunchPageController', template: JST['pages/lunch_page'](), resolve: {
    lunch: (LunchDAO) -> LunchDAO.today()
  })
)


