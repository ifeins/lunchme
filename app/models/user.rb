class User < ActiveRecord::Base
  has_one :account, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  belongs_to :office

  attr_accessible :avatar_url, :email, :first_name, :last_name, :account_attributes, :office_id, :office_attributes, :banned
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :office

  def ban!
    update_attributes(banned: true)
  end

  def unban!
    update_attributes(banned: false)
  end

end
