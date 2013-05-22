class window.Restaurant

  constructor: (data = {}) ->
    @votes = []
    _.each(_.keys(data), (key) => @[key] = data[key])

  addVote: (vote) ->
    @votes.push vote

  getVoters: ->
    _.map(@votes, (vote) -> vote.user)
