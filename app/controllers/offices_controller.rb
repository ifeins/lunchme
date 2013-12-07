class OfficesController < ApplicationController

  respond_to :json

  def index
    respond_with Office.all
  end

  def create
    office = Office.create(params[:office])
    respond_with office
  end


end