class ApplicationController < ActionController::Base
  protect_from_forgery

  include UserSupport
  include ErrorSupport
  include CorsSupport

  before_filter :must_not_be_banned, :sign_out_if_needed
  after_filter :set_ng_xsrf_token
  after_filter :allow_cross_origin

  def set_ng_xsrf_token
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || request.headers['X-XSRF-TOKEN'] == form_authenticity_token
  end

end
