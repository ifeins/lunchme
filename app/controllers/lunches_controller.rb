class LunchesController < ApplicationController

  respond_to :json

  def show
    respond_with_lunch Lunch.find_by_date(params[:id])
  end

  def today
    respond_with_lunch Lunch.find_by_date(Date.today)
  end

  private

  def respond_with_lunch(lunch)
    if lunch.present?
      respond_with lunch
    else
      head :not_found
    end
  end


end