class ApplicationController < ActionController::Base
  protect_from_forgery

  include UserSupport
  include ErrorSupport

  before_filter :must_not_be_banned
  after_filter :set_ng_xsrf_token

  def set_ng_xsrf_token
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || request.headers['X-XSRF-TOKEN'] == form_authenticity_token
  end

end
