class Visit < ActiveRecord::Base
  belongs_to :lunch
  belongs_to :user
  belongs_to :restaurant


end
