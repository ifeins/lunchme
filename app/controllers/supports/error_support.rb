module ErrorSupport
  extend ControllerSupport::Base

  def forbidden
    if request.xhr? or request.format != :html
      head :forbidden
    else
      render 'application/forbidden'
    end
  end
end