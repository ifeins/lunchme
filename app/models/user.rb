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
    update!(forced_sign_out_at: DateTime.current)
  end

  def should_sign_out?
    return false if forced_sign_out_at.nil?

    if last_sign_in_at.nil?
      # if this value doesn't exist then it means that it's the first time it is invoked after this change
      # was deployed and so the user should be forced to sign out
      return true
    end

    last_sign_in_at < forced_sign_out_at
  end

end
