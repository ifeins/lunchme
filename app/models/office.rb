class Office < ActiveRecord::Base
  belongs_to :location
  has_many :users

  attr_accessible :name
end
