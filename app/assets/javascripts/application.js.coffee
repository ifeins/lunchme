#= require jquery
#= require jquery_ujs
#= require underscore
#= require hamlcoffee
#= require string
#= require_tree ../templates
#= require angular/angular
#= require angular/angular-resource
#= require_tree ./angular
#= require_self

_camelCaseObject = (data) ->
  _.each(_.keys(data), (key) ->
    data[S(key)] = data[key]
    delete data[key]
  data

angular.module('Lunchme', ['DAO']).config(($routeProvider, $httpProvider) ->
  $httpProvider.defaults.transformResponse.push((value) ->
    if isArray(value)
      _.map(value, (data) -> _camelCaseObject(data))
    else
      _camelCaseObject(value)
  )

  $routeProvider.when('/', controller: 'LunchPageController', template: JST['pages/lunch_page'](), resolve: {
    lunch: (LunchDAO) -> LunchDAO.today()
  })
)


