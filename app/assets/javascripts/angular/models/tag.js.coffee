class window.Tag

  constructor: (data) ->
    @id = data.id
    @name = data.name
    @quantity = data.quantity
    @restaurant = data.restaurant
    @usersIds = data.userIds || []

  vote: (user) ->
    @quantity++
    @usersIds.push(user.id)

  unvote: (user) ->
    @quantity--
    @usersIds.splice(@usersIds.indexOf(user.id)) if @userVotedFor(user)

  userVotedFor: (user) ->
    _.contains(@usersIds, user.id)

  toJSON: ->
    name: @name
    quantity: @quantity