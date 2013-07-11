class SessionController < ApplicationController

  respond_to :html, :only => [:create, :failure, :destroy]
  respond_to :json

  before_filter :sign_in_required, :only => [:update]

  def create
    account = Account.find_or_create_by_provider_and_uid(
        normalize_provider(auth_hash[:provider]),
        auth_hash[:uid],
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
      format.html { redirect_to root_url }
    end
  end

  def update
    area_name = params[:area].try(:[], :name)
    area = Area.find_by_name(area_name) if area_name.present?
    current_user.update_attribute(:area, area)

    respond_with current_user, :location => root_path
  end

  def failure

  end

  def destroy
    sign_out
    respond_with nil, :location => root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def normalize_provider(provider)
    case provider.to_sym
      when :google_oauth2 then :google
      else :unknown
    end
  end

end