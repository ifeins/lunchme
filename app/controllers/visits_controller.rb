class VisitsController < ApplicationController

  respond_to :json

  before_filter :sign_in_required
  before_filter :current_visit, :only => [:update]

  def create
    visit = current_lunch.visits.create(:user => current_user, :restaurant => visit_restaurant)
    respond_with visit, :location => lunch_url(current_lunch)
  end

  def update
    current_visit.update_attributes(:restaurant => visit_restaurant)
    respond_with current_visit, :location => lunch_url(current_lunch)
  end

  private

  def visit_restaurant
    Restaurant.find(params[:restaurant_id])
  end

  def current_visit
    @_current_visit ||= current_lunch.visits.for_user(current_user).find(params[:id])
  end

  def current_lunch
    @_current_lunch ||= Lunch.find params[:lunch_id]
  end

end