class Lunch < ActiveRecord::Base
  belongs_to :group
  attr_accessible :date
end
