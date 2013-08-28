class RestaurantsController < ApplicationController

  respond_to :json

  attr_reader :restaurant

  before_filter :load_restaurant, :only => [:available_tags]

  def index
    respond_with Restaurant.all
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