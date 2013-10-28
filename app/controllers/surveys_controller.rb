class SurveysController < ApplicationController

  respond_to :json

  def create
    survey = current_lunch.surveys.create(:user => current_user, :status => params[:status])
    respond_with survey, :location => lunch_url(current_lunch)
  end

  private

  def current_lunch
    @_current_lunch ||= Lunch.find(params[:lunch_id])
  end

end