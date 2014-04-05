class window.Location

  @fromGooglePlace: (place) ->
    return unless _.isObject(place)

    coordinates = @_coordinatesFromGooglePlace(place)
    new @(
      street: @_streetFromGooglePlace(place)
      city: @_cityFromGooglePlace(place)
      latitude: coordinates.latitude
      longitude: coordinates.longitude
    )

  @_findAddressCompByType: (addressComps, type) ->
    _.find(addressComps, (comp) -> comp.types[0] == type)

  @_streetFromGooglePlace: (place) ->
    addressComps = place.address_components
    street = @_findAddressCompByType(addressComps, 'route')?.long_name
    streetNumber = @_findAddressCompByType(addressComps, 'street_number')?.long_name

    if _.isEmpty(street) or _.isEmpty(streetNumber)
      null
    else
      "#{street} #{streetNumber}"

  @_cityFromGooglePlace: (place) ->
    @_findAddressCompByType(place.address_components, 'locality')?.long_name

  @_coordinatesFromGooglePlace: (place) ->
    coordinates = place.geometry.location
    latitude: coordinates.pb or coordinates.nb or coordinates.d or coordinates.k
    longitude: coordinates.qb or coordinates.ob or coordinates.e or coordinates.A

  constructor: (data) ->
    @id = data.id
    @street = data.street
    @city = data.city
    @address = data.address
    @latitude = data.latitude
    @longitude = data.longitude

  toJSON: ->
    street: @street
    city: @city
    latitude: @latitude
    longitude: @longitude

