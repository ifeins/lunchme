class Visit < ActiveRecord::Base
  belongs_to :lunch
  belongs_to :user
  belongs_to :restaurant

  scope :for_user, ->(user) { where(user_id: user.id) }

  attr_accessible :user, :restaurant
end
