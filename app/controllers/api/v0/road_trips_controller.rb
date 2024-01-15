class  Api::V0::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    # binding.pry
    if user
      
    else

    end
  end
  
  private

end