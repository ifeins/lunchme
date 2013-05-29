class Restaurant < ActiveRecord::Base
  belongs_to :category
  belongs_to :location
  belongs_to :area
  attr_accessible :name
end
