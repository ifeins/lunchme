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

_camelCaseObject = (obj) ->
  return _.map(obj, (data) -> _camelCaseObject(data)) if _.isArray(obj)

  _.each(_.keys(obj), (key) ->
    value = obj[key]
    if _.isArray(value) or _.isObject(value)
      value = _camelCaseObject(value)

    camelizedKey = S(key).camelize().s
    if camelizedKey != key
      obj[camelizedKey] = value
      delete obj[key]
  )
  obj

angular.module('Lunchme', ['DAO', 'UI']).config(($routeProvider, $httpProvider) ->
  $httpProvider.defaults.transformResponse.push((value) ->
    _camelCaseObject(value)
  )

  $routeProvider.when('/', controller: 'LunchPageController', template: JST['pages/lunch_page'](), resolve: {
    lunch: (LunchDAO) -> LunchDAO.today()
  })
)


