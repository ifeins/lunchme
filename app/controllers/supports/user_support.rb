module UserSupport
  extend ControllerSupport::Base

  USER_SESSION_KEY = :user

  helper_method :current_user, :user_signed_in?

  def current_user
    @_current_user ||= load_user
  end

  def user_signed_in?
    current_user.present?
  end

  def sign_in(user)
    session[USER_SESSION_KEY] = user.id
  end

  def sign_out
    session[USER_SESSION_KEY] = nil
  end

  private

  def load_user
    user_id = session[USER_SESSION_KEY]
    user_id.present? ? User.find(user_id) : nil
  end

end