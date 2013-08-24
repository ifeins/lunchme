class window.Tag

  constructor: (data) ->
    @id = data.id
    @name = data.name
    @quantity = data.quantity
    @restaurant = data.restaurant

  increment: ->
    @quantity++

  decrement: ->
    @quantity--

  toJSON: ->
    name: @name
    quantity: @quantity