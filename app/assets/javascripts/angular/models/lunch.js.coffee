class window.Lunch

  constructor: (@id, @date, @votes = [], @visits = []) ->

  getRestaurants: ->
    _.uniq(_.map(@votes, (vote) -> vote.restaurant))

  # vote methods
  # NOTE: all those methods are nested under lunch and not under restaurant because a user votes on
  # a restaurant in a specific lunch and in the next lunch he may not vote for it so the context here is lunch

  votesForRestaurant: (restaurant) ->
    _.select(@votes, (vote) -> vote.restaurant == restaurant)

  userVotes: (user) ->
    _.select(@votes, (vote) -> vote.user == user)

  userRestaurants: (user) ->
    _.pluck(@userVotes(user), 'restaurant')

  votersForRestaurant: (restaurant) ->
    _.pluck(@votesForRestaurant(restaurant), 'user')

  userVoteForRestaurant: (user, restaurant) ->
    _.find(@votesForRestaurant(restaurant), (vote) -> vote.user == user)

  isVotedForRestaurant: (user, restaurant) ->
    @userVoteForRestaurant(user, restaurant)?

  addVote: (vote) ->
    @votes.push vote

  removeVote: (vote) ->
    @votes.splice(@votes.indexOf(vote), 1)

  addVisit: (visit) ->
    @visits.push visit

  removeVisit: (visit) ->
    @visits.splice(@visits.indexOf(visit), 1)

  hasVisited: ->
    # user can only visit one restaurant per lunch, so there is no need to receive the restaurant as parameter
    _.findWhere(@visits, user: User.current)
