class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :localized_name, :logo_url
  has_many :tags
  has_one :location

  def logo_url
    object.logo.url
  end

end