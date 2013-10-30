class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :localized_name, :logo_url, :address
  has_many :tags

  def logo_url
    object.logo.url
  end

  def address
    "#{object.location.street}, #{object.location.city}"
  end
end