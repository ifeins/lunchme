class window.Lunch

  constructor: (@date, @votes) ->

  getRestaurants: ->
    _.map(@votes, (vote) -> vote.restaurant)
