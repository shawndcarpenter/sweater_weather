class  Api::V0::UsersController < ApplicationController
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
end