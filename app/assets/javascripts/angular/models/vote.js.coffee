class window.Vote

  constructor: (restaurantDAO, data = {}) ->
    @restaurantDAO = restaurantDAO
    _.each(_.keys(data), (key) -> @[key] = data[key])

  getRestaurant: ->
    @restaurantDAO.find(@data.restaurant)