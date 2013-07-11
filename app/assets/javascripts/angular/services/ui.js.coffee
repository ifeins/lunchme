class Modal

  constructor: (config) ->
    @$el = $('#modal')
    @$el.empty()

    @$el.addClass(config.className) if config.className
    @$el.attr('ng-controller', config.controller) if config.controller
    @$el.append(JST[config.template])
    @centerModal()

    $('#modal-overlay').show()
    @$el.show()
    angular.bootstrap(@$el)

  centerModal: ->
    viewportWidth = $('body').width()
    viewportHeight = $(window).height()
    left = (viewportWidth - @$el.width()) / 2;
    top = (viewportHeight - @$el.outerHeight()) / 2;

    @$el.css('left', left)
    @$el.css('top', top)

angular.module('UI', []).factory('$modal', ->
  ModalFactory = (config) ->
    hide = ->
      $('#modal').hide()
      $('#modal-overlay').hide()

    $('#modal-overlay').click(->
      hide()
    )

    if _.isString(config) and config == 'hide'
      hide()
    else
      new Modal(config)

  ModalFactory
)
