class window.Tag

  constructor: (data) ->
    @id = data.id
    @name = data.name
    @quantity = data.quantity

  increment: ->
    @quantity++

  decrement: ->
    @quantity--

  toJSON: ->
    name: @name
    quantity: @quantity