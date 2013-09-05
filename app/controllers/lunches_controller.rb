class LunchesController < ApplicationController

  respond_to :json

  def show
    respond_with Lunch.find_by_date(params[:id])
  end

  def today
    respond_with Lunch.where(date: Date.today)
  end

end