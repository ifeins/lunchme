class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :street, :city

  geocoded_by :address
  after_validation :geocode, :if => ->(location) { location.latitude.blank? or location.longitude.blank? }

  def address
    [street, city, 'Israel'].compact.join(', ')
  end

end
