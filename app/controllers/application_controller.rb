class ApplicationController < ActionController::Base
  protect_from_forgery

  include UserSupport
  include ErrorSupport
end
