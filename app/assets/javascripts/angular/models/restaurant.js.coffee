class window.Restaurant

  constructor: (data = {}) ->
    @id = data.id
    @name = data.name
    @logoUrl = data.logoUrl
    @address = data.address
    @tags = []
    _.each(data.tags, (tagData) => @addTag(new Tag(tagData))) if data.tags

  addTag: (tag) ->
    tag.restaurant = @
    @tags.push tag


  removeTag: (tag) ->
    index = @tags.indexOf(tag)
    @tags.splice(index, 1)

