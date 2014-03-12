module ErrorSupport
  extend ControllerSupport::Base

  def forbidden
    if request.xhr? or request.format != :html
      head :forbidden
    else
      render 'application/forbidden'
    end
  end

  def banned
    if request.xhr? or request.format != :html
      head :forbidden
    else
      render 'application/banned'
    end
  end
end