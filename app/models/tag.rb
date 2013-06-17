class Tag < ActiveRecord::Base
  belongs_to :tag_definition
  belongs_to :restaurant
  attr_accessible :quantity, :tag_definition
end
