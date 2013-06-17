class TagSerializer < ActiveModel::Serializer

  attributes :name, :quantity

  def name
    object.tag_definition.name
  end

end