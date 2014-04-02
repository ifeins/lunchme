class RestaurantsController < ApplicationController

  respond_to :json

  attr_reader :restaurant

  before_filter :load_restaurant, :only => [:available_tags]

  # the radius around the office's location to search restaurants in
  RADIUS = 1.5

  def index
    if user_signed_in? and current_user.office.try(:location).present?
      origin = current_user.office.location
      locations = Location.within(RADIUS, origin: origin).by_distance(origin: origin)
      restaurants = locations.map {|location| Restaurant.find_by_location_id(location.id) }.compact
    else
      restaurants = Restaurant.all
    end

    respond_with restaurants
  end

  def available_tags
    restaurant_tags = restaurant.tags.map { |tag| tag.tag_definition.name }
    all_tags = TagDefinition.all.map(&:name)

    result = all_tags - restaurant_tags
    respond_with result
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end