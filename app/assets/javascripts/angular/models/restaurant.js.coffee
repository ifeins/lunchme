class window.Restaurant

  constructor: (data = {}) ->
    @id = data.id
    @name = data.name
    @localizedName = data.localizedName
    @logoUrl = data.logoUrl
    @location = new Location(data.location)
    @tags = []
    _.each(data.tags, (tagData) => @addTag(new Tag(tagData))) if data.tags

  addTag: (tag) ->
    tag.restaurant = @
    @tags.push tag

  removeTag: (tag) ->
    index = @tags.indexOf(tag)
    @tags.splice(index, 1)

  containsTag: (tag) ->
    _.find(@tags, (currTag) -> currTag.name == tag.name)?

