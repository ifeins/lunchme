class Office < ActiveRecord::Base
  belongs_to :location
  has_many :users

  attr_accessible :name, :location_attributes
  accepts_nested_attributes_for :location
end
