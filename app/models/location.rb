class Location < ActiveRecord::Base
  acts_as_mappable default_units: :kms, lat_column_name: :latitude, lng_column_name: :longitude

  def address
    [street, city].compact.join(', ')
  end

end
