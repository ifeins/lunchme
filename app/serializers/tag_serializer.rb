class TagSerializer < ActiveModel::Serializer

  attributes :id, :name, :quantity

  def name
    object.tag_definition.name
  end

end