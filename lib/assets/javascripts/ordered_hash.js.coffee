class window.OrderedHash

  constructor: ->
    @values = []
    @keyToValueIndexMap = {}

  set: (key, value) ->
    index = @keyToValueIndexMap[key]
    if index
      @values[index] = value
    else
      @values.push value
      @keyToValueIndexMap[key] = @values.length - 1

  get: (key) ->
    index = @keyToValueIndexMap[key]
    @values[index]

  all: ->
    @values