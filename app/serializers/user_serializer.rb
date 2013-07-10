class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :avatar_url, :work_area

  def work_area
    object.area.name
  end

  def include_work_area?
    object.area.present?
  end

end