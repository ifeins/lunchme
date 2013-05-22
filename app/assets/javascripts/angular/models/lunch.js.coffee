class window.Lunch

  constructor: (data = {}) ->
    @date = data.date
    @votes = _.map(data.votes, (voteData) =>
      user = @_findUser(data.users, voteData.userId)
      restaurant = @_findRestaurant(data.restaurants, voteData.restaurantId)
      vote = new Vote(user, restaurant)
      restaurant.addVote(vote)
      vote
    )

  getRestaurants: ->
    _.map(@votes, (vote) -> vote.restaurant)

  _findUser: (list = [], id) ->
    data = _.findWhere(list, id: id)
    if data then new User(data) else null

  _findRestaurant: (list = [], id) ->
    data = _.findWhere(list, id: id)
    if data then new Restaurant(data) else null







