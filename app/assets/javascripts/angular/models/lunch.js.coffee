class window.Lunch

  date: null
  votes: []

  constructor: (data = {}) ->
    @date = data.date
    @votes = _.map(data.votes, (voteData) =>
      user = @_findUser(data.users, voteData.userId)
      restaurant = @_findRestaurant(data.restaurants, voteData.restaurantId)
      new Vote(user, restaurant)
    )

  getRestaurants: ->
    _.map(@votes, (vote) -> vote.restaurant)

  _findUser: (list = [], id) ->
    data = _.findWhere(list, id: id)
    if data then new User(data) else null

  _findRestaurant: (list = [], id) ->
    data = _.findWhere(list, id: id)
    if data then new Restaurant(data) else null







