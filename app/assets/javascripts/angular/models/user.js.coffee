class window.User

  @parse: (attributes) ->
    new @(Utils.camelCaseObject(attributes))

  constructor: (data = {}) ->
    _.each(_.keys(data), (key) => @[key] = data[key])

  fullName: ->
    "#{@firstName} #{@lastName}"

  isCurrentUser: ->
    @id == @constructor.current?.id

