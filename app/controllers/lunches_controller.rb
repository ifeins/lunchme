class LunchesController < ApplicationController

  respond_to :json

  def show
    respond_with Lunch.where(date: params[:id]).first
  end

  def today
    respond_with Lunch.where(date: Date.today).first
  end

  def yesterday
    respond_with Lunch.where(date: Date.yesterday).first
  end

end