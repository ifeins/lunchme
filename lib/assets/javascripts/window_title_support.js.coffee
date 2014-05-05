class window.WindowTitleSupport

  @originalTitle: 'Lunchtime'
  @windowTitle: null
  @showNewTitle: false
  @hasFocus: true
  @interval: null

  @bindEvents: ->
    _.bindAll(@, '_focus', '_blur', '_flip')
    $(window).focus(@_focus)
    $(window).blur(@_blur)

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
    else
      Utils.setWindowTitle(@originalTitle)

WindowTitleSupport.bindEvents()

