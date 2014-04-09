class OfficesController < ApplicationController

  respond_to :json

  def index
    respond_with Office.all
  end

  def create
    office = Office.create(office_create_params)
    respond_with office
  end

  private

  def office_create_params
    params.require(:office).permit(:name, :location_attributes => [:latitude, :longitude, :street, :city])
  end

end