angular.module('UI', []).factory('$modal', ->
  ModalFactory = (config) ->
    hide = ->
      $('#modal').hide()
      $('#modal-overlay').hide()

    $('#modal-overlay').click(->
      hide()
    )

    Modal = (config) ->
      $modalEl = $('#modal')
      $modalEl.empty()

      $modalEl.addClass(config.className) if config.className
      $modalEl.append(JST[config.template])

      $('#modal-overlay').show()
      $modalEl.show()

    new Modal(config)

  ModalFactory
)
