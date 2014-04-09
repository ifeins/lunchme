class Office < ActiveRecord::Base
  belongs_to :location, :dependent => :destroy
  has_many :users, :dependent => :nullify

  accepts_nested_attributes_for :location
end
