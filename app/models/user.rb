class User < ActiveRecord::Base
  has_one :account
  has_many :votes
  belongs_to :area

  attr_accessible :avatar_url, :email, :first_name, :last_name, :account_attributes, :area
  accepts_nested_attributes_for :account
end
