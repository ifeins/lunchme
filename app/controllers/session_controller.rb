class SessionController < ApplicationController

  respond_to :json, :html

  def create
    account = Account.find_or_create_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
    unless account.user.present?
      account.create_user(:first_name => auth_hash[:info][:first_name],
                          :last_name => auth_hash[:info][:last_name],
                          :email => auth_hash[:info][:email],
                          :avatar_url => auth_hash[:info][:image]
      )
    end

    respond_with account.user do |format|
      format.html { redirect_to root_url }
    end
  end

  def failure

  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end