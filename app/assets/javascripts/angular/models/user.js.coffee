class window.User

  constructor: (data = {}) ->
    _.each(_.keys(data), (key) => @[key] = data[key])