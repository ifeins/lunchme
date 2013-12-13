class window.Location

  @fromGooglePlace: (place) ->
    addressComps = place.address_components
    coordinates = place.geometry.location

    street = @_findAddressCompByType(addressComps, 'route')?.long_name
    streetNumber = @_findAddressCompByType(addressComps, 'street_number')?.long_name
    city = @_findAddressCompByType(addressComps, 'locality')?.long_name

    return null if _.isEmpty(street) or _.isEmpty(streetNumber) or _.isEmpty(city)

    new @(
      street: "#{street} #{streetNumber}"
      city: city
      latitude: coordinates.pb or coordinates.nb
      longitude: coordinates.qb or coordinates.ob
    )

  @_findAddressCompByType: (addressComps, type) ->
    _.find(addressComps, (comp) -> comp.types[0] == type)

  constructor: (data) ->
    @id = data.id
    @street = data.street
    @city = data.city
    @latitude = data.latitude
    @longitude = data.longitude

  toJSON: ->
    street: @street
    city: @city
    latitude: @latitude
    longitude: @longitude

