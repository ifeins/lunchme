class Survey < ActiveRecord::Base
  belongs_to :user
  belongs_to :lunch

  enum :status, [:skipped, :completed]
end
