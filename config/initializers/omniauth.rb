Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, GOOGLE.app_id, GOOGLE.secret
end