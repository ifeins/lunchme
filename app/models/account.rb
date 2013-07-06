class Account < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid, :user_attributes
  accepts_nested_attributes_for :user
end
