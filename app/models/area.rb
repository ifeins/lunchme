class Area < ActiveRecord::Base
  has_many :users

  attr_accessible :latitude, :longitude, :name, :radius
end
