class Lunch < ActiveRecord::Base
  has_many :votes
  has_many :visits

  attr_accessible :date

  def to_param
    date.to_s
  end
end
