class Restaurant < ActiveRecord::Base
  belongs_to :location, :dependent => :destroy
  has_and_belongs_to_many :payment_methods, :join_table => :accepted_payment_methods
  has_many :tags, :dependent => :destroy

  mount_uploader :logo, LogoUploader

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :tags
end
