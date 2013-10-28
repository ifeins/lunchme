class window.Survey

  constructor: (@status, @user, @lunch) ->

  toJSON: ->
    status: @status