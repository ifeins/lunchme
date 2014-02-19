class window.Vote

  constructor: (lunch, user, restaurant) ->
    @lunch = lunch
    @user = user
    @restaurant = restaurant

  isEqual: (otherVote) ->
    @lunch.id == otherVote.lunch.id and @user.id == otherVote.user.id and @restaurant.id == otherVote.restaurant.id

  toJSON: ->
    lunch_id: @lunch.id
    user_id: @user.id
    restaurant_id: @restaurant.id