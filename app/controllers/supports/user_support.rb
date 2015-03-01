module UserSupport
  extend ControllerSupport::Base

  USER_SESSION_KEY = :user
  USER_HEADER = 'X-Lunchtime-User'

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

  def sign_in_required
    forbidden unless user_signed_in?
  end

  def must_not_be_banned
    banned if user_signed_in? and current_user.banned?
  end

  def sign_out_if_needed
    sign_out if user_signed_in? and current_user.should_sign_out?
  end

  private

  def load_user
    user_id = session[USER_SESSION_KEY].presence || request.headers[USER_HEADER]
    user_id.present? ? User.find_by_id(user_id) : nil
  end

end