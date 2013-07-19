class window.Vote

  constructor: (lunch, user, restaurant) ->
    @lunch = lunch
    @user = user
    @restaurant = restaurant

  toJSON: ->
    lunch_id: @lunch.id
    user_id: @user.id
    restaurant_id: @restaurant.id