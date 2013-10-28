class Lunch < ActiveRecord::Base
  has_many :votes
  has_many :visits
  has_many :surveys

  attr_accessible :date

  def self.today
    find_by_date(Date.today)
  end

  def self.yesterday
    find_by_date(Date.yesterday)
  end

  def user_survey(user)
    surveys.find_by_user_id(user.id)
  end

  def to_param
    date.to_s
  end
end
