class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :street, :city
  acts_as_mappable default_units: :kms, lat_column_name: :latitude, lng_column_name: :longitude

  def address
    [street, city].compact.join(', ')
  end

end
