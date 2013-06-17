class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url
  has_many :tags
end