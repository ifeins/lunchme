class LunchSerializer < ActiveModel::Serializer
  attributes :id, :date
  has_many :votes

end