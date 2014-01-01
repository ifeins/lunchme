class TagSerializer < ActiveModel::Serializer

  attributes :id, :name, :quantity
  has_many :users, embed: :ids

  def name
    object.tag_definition.name
  end

end