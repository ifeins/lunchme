class User < ActiveRecord::Base
  has_one :account, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  belongs_to :office

  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :office

  def ban!
    update_attribute(:banned, true)
  end

  def unban!
    update_attribute(:banned, false)
  end

  def force_sign_out!
    update!(forced_sign_out_at: Time.now.to_i)
  end

end
