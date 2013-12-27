class Tag < ActiveRecord::Base
  belongs_to :tag_definition
  belongs_to :restaurant
  has_and_belongs_to_many :users

  attr_accessible :quantity, :tag_definition
end
