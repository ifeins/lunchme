class User < ActiveRecord::Base
  has_one :account, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  belongs_to :office

  attr_accessible :avatar_url, :email, :first_name, :last_name, :account_attributes, :office_id, :office_attributes
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :office
end
