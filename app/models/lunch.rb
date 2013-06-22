class Lunch < ActiveRecord::Base
  has_many :votes

  attr_accessible :date
end
