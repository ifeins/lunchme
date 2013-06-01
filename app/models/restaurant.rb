class Restaurant < ActiveRecord::Base
  belongs_to :category
  belongs_to :location
  belongs_to :area
  has_and_belongs_to_many :payment_method, :join_table => :accepted_payment_methods
  attr_accessible :name, :category, :location_attributes

  accepts_nested_attributes_for :location
end
