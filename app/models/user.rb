class User < ActiveRecord::Base
  has_one :account
  belongs_to :area

  attr_accessible :avatar_url, :email, :first_name, :last_name, :account_attributes
  accepts_nested_attributes_for :account
end
