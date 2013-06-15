class Lunch < ActiveRecord::Base
  belongs_to :group
  has_many :votes

  attr_accessible :date, :group
end
