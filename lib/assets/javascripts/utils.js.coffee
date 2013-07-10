class window.Utils

  @camelCaseObject = (obj) ->
    return _.map(obj, (data) -> Utils.camelCaseObject(data)) if _.isArray(obj)

    _.each(_.keys(obj), (key) ->
      value = obj[key]
      if _.isArray(value) or _.isObject(value)
        value = Utils.camelCaseObject(value)

      camelizedKey = S(key).camelize().s
      if camelizedKey != key
        obj[camelizedKey] = value
        delete obj[key]
    )
    obj