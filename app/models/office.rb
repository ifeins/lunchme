class Office < ActiveRecord::Base
  belongs_to :location, :dependent => :destroy
  has_many :users, :dependent => :nullify

  attr_accessible :name, :location_attributes
  accepts_nested_attributes_for :location
end
