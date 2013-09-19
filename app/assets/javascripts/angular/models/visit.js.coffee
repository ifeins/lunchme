class window.Visit

  constructor: (@lunch, @user, @restaurant) ->

  toJSON: ->
    restaurant_id: @restaurant.id