class window.Restaurant

  constructor: (data = {}) ->
    @votes = []
    _.each(_.keys(data), (key) => @[key] = data[key])

  vote: (user) ->
    @addVote(new Vote(user, @))

  unvote: (user) ->
    userVote = _.find(@votes, (vote) -> vote.user == user)
    @votes.splice(@votes.indexOf(userVote), 1)

  isVotedFor: (user) ->
    user in _.pluck(@votes, 'user')

  addVote: (vote) ->
    @votes.push vote

  getVoters: ->
    _.map(@votes, (vote) -> vote.user)
