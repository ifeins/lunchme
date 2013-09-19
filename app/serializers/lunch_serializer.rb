class LunchSerializer < ActiveModel::Serializer
  attributes :id, :date
  has_many :votes
  has_many :visits
end