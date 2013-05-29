class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :radius
end
