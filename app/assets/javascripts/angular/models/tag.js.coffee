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
    return false unless user
    _.contains(@usersIds, user.id)

  canVoteFor: (user) ->
    return false unless user
    not @userVotedFor(user)

  toJSON: ->
    name: @name
    quantity: @quantity