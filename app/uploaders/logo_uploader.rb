# encoding: utf-8
class LogoUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def default_url
    ActionController::Base.helpers.image_path('default-restaurant-logo.png')
  end
end
