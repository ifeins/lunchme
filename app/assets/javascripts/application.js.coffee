#= require assets
#= require jquery
#= require jquery_ujs
#= require underscore
#= require hamlcoffee
#= require string
#= require moment
#= require routes
#= require browser
#= require utils
#= require ordered_hash
#= require typeahead
#= require_tree ../templates
#= require angular
#= require selectize
#= require_self
#= require_tree ./angular

dateFromRoute = (dateParam) ->
  if dateParam == 'today'
    moment()
  else if dateParam == 'yesterday'
    moment().subtract('days', 1)
  else
    moment(dateParam)

window.safeApply = (scope, fn) ->
  if (scope.$$phase || scope.$root.$$phase) then fn() else scope.$apply(fn)

window.Lunchtime = angular.module('Lunchtime', ['ngRoute', 'ngAnimate', 'DAO', 'UI', 'doowb.angular-pusher']).config(($routeProvider, $httpProvider, PusherServiceProvider) ->
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'

  $httpProvider.defaults.transformResponse.push((value, headers) ->
    contentType = headers('content-type')

    if contentType and contentType.indexOf('application/json') != -1
      if value then Utils.camelCaseObject(value) else value
    else
      value
  )

  $routeProvider.when('/',
    redirectTo: 'lunches/today'
  ).when('/lunches/:date',
    controller: 'LunchPageController'
    template: JST['pages/lunch_page']()
    resolve:
      lunch: ['$route', 'LunchDAO', ($route, LunchDAO) -> LunchDAO.findByDate($route.current.params.date)]
      yesterdayLunch: ['$route', 'LunchDAO', ($route, LunchDAO) ->
        lunchDate = dateFromRoute($route.current.params.date)
        yesterdayDate = lunchDate.subtract('days', 1).format('YYYY-MM-DD')
        LunchDAO.findByDate(yesterdayDate)
      ]
  )

  PusherServiceProvider.setPusherUrl('http://js.pusher.com/2.2/pusher.min.js')
  PusherServiceProvider.setToken(PusherConfig.appKey)

)


