class LunchesController < ApplicationController

  respond_to :json

  def show
    respond_with Lunch.find(params[:id])
  end

end