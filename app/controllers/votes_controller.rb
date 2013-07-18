class VotesController < ApplicationController

  before_filter :load_restaurant
  before_filter :load_lunch

  attr_reader :lunch, :restaurant

  respond_to :json

  def create
    vote = lunch.votes.create(:user => current_user, :restaurant => restaurant)
    respond_with vote, :location => root_url
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def load_lunch
    @lunch = Lunch.find(params[:lunch_id])
  end

end