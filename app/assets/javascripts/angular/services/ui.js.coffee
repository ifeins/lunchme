class Modal

  constructor: (config, $controller, $rootScope, $compile, $timeout, $interpolate) ->
    @$el = $('#modal')
    @$el.empty()
    @$el.removeClass() # remove all previous classes of the element
    @$el.addClass(config.className) if config.className

    scope = $rootScope.$new()
    for local of config.locals
      scope[local] = config.locals[local]

    @$el.append(JST[config.template]())
    $compile(@$el)(scope)
    @centerModal()

    $('#modal-overlay').show()
    @$el.show()

    $controller(config.controller, $scope: scope) if config.controller


  centerModal: ->
    viewportWidth = $('body').width()
    viewportHeight = $(window).height()
    left = (viewportWidth - @$el.width()) / 2;
    top = (viewportHeight - @$el.outerHeight()) / 2;

    @$el.css('left', left)
    @$el.css('top', top)

angular.module('UI', []).factory('$modal', ($controller, $rootScope, $compile, $timeout, $interpolate) ->
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
      new Modal(config, $controller, $rootScope, $compile, $timeout, $interpolate)

  ModalFactory
)
