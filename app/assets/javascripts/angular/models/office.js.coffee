class window.Office

  constructor: (data = {}) ->
    @id = data.id
    @name = data.name
    @street = data.location.street
    @city = data.location.city
    @longitude = data.location.longitude
    @latitude = data.location.latitude

