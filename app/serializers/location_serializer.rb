class LocationSerializer < ActiveModel::Serializer
  attributes :street, :city, :address, :longitude, :latitude
end