class window.Office

  constructor: (data = {}) ->
    @id = data.id
    @name = data.name
    @street = data.location.street
    @city = data.location.city
    @latitude = data.location.latitude
    @longitude = data.location.longitude

  toJSON: ->
    name: @name
    location_attributes:
      street: @street
      city: @city
      latitude: @latitude
      longitude: @longitude

