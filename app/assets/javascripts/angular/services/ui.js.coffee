angular.module('UI', []).factory('$modal', ->
  ModalFactory = (config) ->
    Modal = (config) ->
      $modalEl = $('<div></div>')
      $modalEl.className(config.className) if config.className
      $modalEl.append(JST[config.template])
      $('#modal').append($modalEl)

    new Modal(config)

  ModalFactory
)
