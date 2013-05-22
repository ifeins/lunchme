class window.Restaurant

  constructor: (data = {}) ->
    _.each(_.keys(data), (key) => @[key] = data[key])