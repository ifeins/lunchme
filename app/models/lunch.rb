class Lunch < ActiveRecord::Base
  has_many :votes

  attr_accessible :date

  def to_param
    date.to_s
  end
end
