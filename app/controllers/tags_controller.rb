class TagsController < ApplicationController

  class TagError < StandardError; end

  attr_reader :restaurant

  before_filter :load_restaurant

  respond_to :json

  def create
    tag_definition = TagDefinition.find_by(name: params[:name])
    if tag_definition.present?
      tag = restaurant.tags.build(:tag_definition => tag_definition)
      tag.users << current_user
      tag.save
      respond_with tag, :location => root_url
    else
      raise TagError.new('Tag is not listed in the predefined tags')
    end
  end

  def destroy
    tag = restaurant.tags.find(params[:id]).destroy
    respond_with tag do |format|
      format.json { render json: tag }
    end
  end

  def vote
    tag = restaurant.tags.find(params[:tag_id])
    raise TagError.new('User already voted for tag') if tag.users.include?(current_user)

    tag.quantity += 1
    tag.users << current_user
    tag.save!

    # by default rails doesn't includes body in response to PUT requests
    respond_with tag do |format|
      format.json { render :json => tag }
    end
  end

  def unvote
    tag = restaurant.tags.find(params[:tag_id])
    raise TagError.new('User did not vote for this tag before') unless tag.users.include?(current_user)

    tag.quantity -= 1
    tag.users.delete(current_user)
    tag.save!

    # by default rails doesn't includes body in response to PUT requests
    respond_with tag do |format|
      format.json { render :json => tag }
    end
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end


end