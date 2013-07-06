class SessionController < ApplicationController

  respond_to :json, :html

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

  def failure

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