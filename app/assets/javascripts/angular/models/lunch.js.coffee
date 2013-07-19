class window.Lunch

  constructor: (@date, @votes = []) ->

  getRestaurants: ->
    _.map(@votes, (vote) -> vote.restaurant)

  # vote methods
  # NOTE: all those methods are nested under lunch and not under restaurant because a user votes on
  # a restaurant in a specific lunch and in the next lunch he may not vote for it so the context here is lunch

  votesForRestaurant: (restaurant) ->
    _.select(@votes, (vote) -> vote.restaurant == restaurant)

  votersForRestaurant: (restaurant) ->
    _.pluck(@votesForRestaurant(restaurant), 'user')

  isVotedForRestaurant: (user, restaurant) ->
    user in @votersForRestaurant(restaurant)

  vote: (restaurant) ->
    @votes.push new Vote(@, User.current, restaurant)

  unvote: (restaurant) ->
    userVote = _.find(@votes, (vote) -> vote.user == User.current and vote.restaurant == restaurant)
    @votes.splice(@votes.indexOf(userVote), 1)
