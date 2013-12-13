class window.Office

  constructor: (data = {}) ->
    @id = data.id
    @name = data.name
    @location = data.location

  toJSON: ->
    name: @name
    location_attributes: @location.toJSON()
