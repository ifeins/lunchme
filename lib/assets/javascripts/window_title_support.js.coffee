class window.WindowTitleSupport

  @originalTitle: 'Lunchtime'
  @windowTitle: null
  @flashActive: false
  @hasFocus: true
  @interval: null
  @animationFrame: 0

  @bindEvents: ->
    _.bindAll(@, '_handleVisibilityChange', '_flip')
    document.addEventListener('webkitvisibilitychange', @_handleVisibilityChange)

  @flashWindowTitle: (title) ->
    return if @hasFocus

    @windowTitle = title
    @flashActive = true

  @_focus: ->
    @hasFocus = true
    clearInterval(@interval)
    @interval = null
    @flashActive = false
    @animationFrame = 0
    @windowTitle = null
    Utils.setWindowTitle(@originalTitle)

  @_blur: ->
    @hasFocus = false
    @interval = setInterval(@_flip, 1500) unless @interval

  @_flip: ->
    return unless @flashActive

    if @animationFrame == 0
      Utils.setWindowTitle(@windowTitle)
      @animationFrame = 1
    else
      Utils.setWindowTitle(@originalTitle)
      @animationFrame = 0

  @_handleVisibilityChange: ->
    if document.hidden
      @_blur()
    else
      @_focus()

WindowTitleSupport.bindEvents()

