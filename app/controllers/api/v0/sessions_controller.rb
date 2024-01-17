class  Api::V0::SessionsController < ApplicationController
  def create
    user = UserFinderJob.perform_now(params[:email])

    if !params[:email] || !params[:password]
      missing_parameters_response(params)
    elsif user && user.authenticate(params[:password])
      render json: UserSerializer.new(user), status: 201
    else
      no_matching_records_response
    end
  end

  private
  
  def no_matching_records_response
    render json: ErrorSerializer.new(ErrorMessage.new("Email or password did not match our records", 422))
    .serialize_json, status: 422
  end

  def missing_parameters_response(params)
    message = []
    if !params[:email] 
      message << "email can't be blank"
    end
      
    if !params[:password]
      message << "password can't be blank"
    end

    render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: #{message.join(", ")}", 422))
    .serialize_json, status: 422
  end
end