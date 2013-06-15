class LunchSerializer < ActiveModel::Serializer
  attributes :date
  has_many :votes

end