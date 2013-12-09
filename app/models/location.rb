class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :street, :city

  def address
    [street, city, 'Israel'].compact.join(', ')
  end

end
