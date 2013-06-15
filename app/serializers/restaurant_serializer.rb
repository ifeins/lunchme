class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo_url, :category

  def category
    object.category.try(:name)
  end
end