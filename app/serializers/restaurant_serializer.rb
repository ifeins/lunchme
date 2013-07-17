class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url
  has_many :tags

  def logo_url
    object.logo.url
  end
end