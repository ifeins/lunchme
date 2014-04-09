class SessionController < ApplicationController

  respond_to :html, :only => [:create, :failure, :destroy]
  respond_to :json, :only => [:update]

  before_filter :sign_in_required, :only => [:update]

  def create
    account = Account.find_or_create_by(:provider => auth_hash[:provider], :uid => auth_hash[:uid])
    account.update(
      :user_attributes => {
        :first_name => auth_hash[:info][:first_name],
        :last_name => auth_hash[:info][:last_name],
        :email => auth_hash[:info][:email],
        :avatar_url => auth_hash[:info][:image]
      }
    )
    user = account.user
    sign_in(user)

    respond_with user do |format|
      format.html do
        redirect_url = auth_additional_params['internal_redirect_url'].presence || root_url
        redirect_to redirect_url
      end
    end
  end

  def update
    current_user.update_attributes(user_update_params)
    respond_with current_user, :location => root_path
  end

  def failure

  end

  def destroy
    sign_out
    redirect_to root_path, status: :see_other
  end

  private

  def user_update_params
    params.require(:user).permit(:office_id, office_attributes: [:name, location_attributes: [:latitude, :longitude, :street, :city]])
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def auth_additional_params
    request.env['omniauth.params']
  end

end