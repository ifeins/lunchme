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

_camelCaseValue = (value) ->
  return _.map(value, (data) -> _camelCaseValue(data)) if _.isArray(value)

  _.each(_.keys(value), (key) ->
    camelizedKey = S(key).camelize().s
    if camelizedKey != key
      value[camelizedKey] = value[key]
      delete value[key]
  )
  value

angular.module('Lunchme', ['DAO']).config(($routeProvider, $httpProvider) ->
  $httpProvider.defaults.transformResponse.push((value) ->
    _camelCaseValue(value)
  )

  $routeProvider.when('/', controller: 'LunchPageController', template: JST['pages/lunch_page'](), resolve: {
    lunch: (LunchDAO) -> LunchDAO.today()
  })
)


