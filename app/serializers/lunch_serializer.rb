class LunchSerializer < ActiveModel::Serializer
  attributes :id, :date, :user_survey
  has_many :votes
  has_many :visits

  def user_survey
    object.user_survey(current_user)
  end

end