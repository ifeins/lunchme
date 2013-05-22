class window.Lunch

  constructor: (voteDAO, data = {}) ->
    @voteDAO = voteDAO
    _.each(_.keys(data), (key) -> @[key] = data[key])

  getRestaurants: ->
    _.map(@votes, (voteId) => voteDAO.find(voteId).getRestaurant())



