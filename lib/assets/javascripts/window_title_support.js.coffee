class window.WindowTitleSupport

  @originalTitle: 'Lunchtime'
  @windowTitle: null
  @showNewTitle: false
  @hasFocus: true
  @interval: null

  @bindEvents: ->
    _.bindAll(@, '_handleVisibilityChange', '_flip')
    document.addEventListener('webkitvisibilitychange', @_handleVisibilityChange)

  @flashWindowTitle: (title) ->
    return if @hasFocus

    @windowTitle = title
    @showNewTitle = true

  @_focus: ->
    @hasFocus = true
    clearInterval(@interval)
    @interval = null
    @showNewTitle = false

  @_blur: ->
    @hasFocus = false
    @interval = setInterval(@_flip, 1500) unless @interval

  @_flip: ->
    if @showNewTitle
      Utils.setWindowTitle(@windowTitle)
      @showNewTitle = false
    else
      Utils.setWindowTitle(@originalTitle)
      @showNewTitle = true

  @_handleVisibilityChange: ->
    if document.hidden
      @_blur()
    else
      @_focus()

WindowTitleSupport.bindEvents()

