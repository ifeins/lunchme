class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url, :category
  has_many :tags

  def category
    object.category.try(:name)
  end
end