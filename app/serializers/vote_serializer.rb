class VoteSerializer < ActiveModel::Serializer
  has_one :user
  has_one :restaurant, :embed => :ids
end