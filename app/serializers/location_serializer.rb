class LocationSerializer < ActiveModel::Serializer
  attributes :street, :city, :longitude, :latitude
end