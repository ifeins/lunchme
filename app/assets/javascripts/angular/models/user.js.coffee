class window.User

  @signIn: ->
    Browser.redirectTo(Routes.sign_in_path('facebook', internal_redirect_url: window.location.toString()))

  @parse: (attributes) ->
    new @(Utils.camelCaseObject(attributes))

  @isSignedIn: ->
    return User.current?

  constructor: (data = {}) ->
    _.each(_.keys(data), (key) => @[key] = data[key])

  fullName: ->
    "#{@firstName} #{@lastName}"

  isCurrentUser: ->
    @id == @constructor.current?.id

