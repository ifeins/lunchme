class window.Browser

  @redirectTo: (url) ->
    window.location.href = url

  @refresh: ->
    window.location.reload()
