class ApplicationController < ActionController::Base
  protect_from_forgery

  include UserSupport
  include ErrorSupport

  before_filter :must_not_be_banned
  after_filter :set_ng_xsrf_token
  after_filter :allow_cross_origin

  def set_ng_xsrf_token
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || request.headers['X-XSRF-TOKEN'] == form_authenticity_token
  end

  def allow_cross_origin
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
  end

end
