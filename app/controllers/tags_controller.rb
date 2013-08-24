class TagsController < ApplicationController

  class InvalidTagError < StandardError; end

  attr_reader :restaurant

  before_filter :load_restaurant

  respond_to :json

  def create
    tag_definition = TagDefinition.find_by_name(params[:name])
    if tag_definition.present?
      tag = restaurant.tags.create(:tag_definition => tag_definition)
      respond_with tag, :location => root_url
    else
      raise InvalidTagError.new('Tag is not listed in the predefined tags')
    end

  end

  def vote
    tag = restaurant.tags.find(params[:tag_id])
    tag.quantity += 1
    tag.save!

    respond_with tag
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end