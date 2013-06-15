class User < ActiveRecord::Base
  belongs_to :group
  has_one :account

  attr_accessible :avatar_url, :email, :first_name, :last_name, :group, :account_attributes
  accepts_nested_attributes_for :account
end
