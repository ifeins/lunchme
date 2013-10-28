class Survey < ActiveRecord::Base
  belongs_to :user
  belongs_to :lunch
  attr_accessible :status, :user

  enum :status, [:skipped, :completed]
end
