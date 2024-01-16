class  Api::V0::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def create
    user = User.create!(email: params[:email], 
                        password: params[:password], 
                        password_confirmation: params[:password_confirmation], 
                        api_key: create_api_key)

    render json: UserSerializer.new(user), status: 201

  end

  private
  
  def create_api_key
    SecureRandom.hex
  end

  def invalid_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422))
    .serialize_json, status: 422
  end
end