class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :street, :city
end
