class  Api::V1::MunchiesController < ApplicationController
  def show
    geo = get_geocoded_location(params[:destination])
    munchie = MunchiesFacade.new(params[:destination], params[:food], geo).munchie

    render json: 
      MunchieSerializer.new(munchie)
  end

  private
  def get_geocoded_location(location)
    geocoded_location = GeolocationFacade.new(location).geocode
  end
end