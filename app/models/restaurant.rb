class Restaurant < ActiveRecord::Base
  belongs_to :location
  belongs_to :area
  has_and_belongs_to_many :payment_methods, :join_table => :accepted_payment_methods
  has_many :tags

  attr_accessible :name, :logo_url, :location_attributes, :tags_attributes, :payment_methods
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :tags
end
