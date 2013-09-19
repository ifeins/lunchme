class VisitsController < ApplicationController

  respond_to :json

  before_filter :sign_in_required

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    visit = current_lunch.visits.create(:user => current_user, :restaurant => restaurant)
    respond_with visit
  end

  private

  def current_lunch
    @_current_lunch = Lunch.find params[:lunch_id]
  end

end