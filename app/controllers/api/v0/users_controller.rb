class  Api::V0::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def create
    if params_missing?
      missing_data_response(params)
    elsif !passwords_match?
      passwords_must_match_response
    else
      user = User.create!(email: params[:email], 
                          password: params[:password], 
                          password_confirmation: params[:password_confirmation], 
                          api_key: create_api_key)

      render json: UserSerializer.new(user), status: 201
    end
  end

  private
  def create_api_key
    SecureRandom.hex
  end

  def params_missing?
    !params[:password] || !params[:password_confirmation] || !params[:email]
  end

  def passwords_match?
    params[:password_confirmation] == params[:password]
  end

  def invalid_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
    .serialize_json, status: 400
  end

  def passwords_must_match_response
    render json: ErrorSerializer.new(ErrorMessage.new(
                                "Password and password confirmation must match",422))
                                .serialize_json, status:422
  end

  def missing_data_response(params)
    message = []

    if !params[:email]
      message << "email can't be blank"
    end

    if !params[:password]
      message << "password can't be blank"
    end

    if !params[:password_confirmation]
      message << "password confirmation can't be blank"
    end

    render json: ErrorSerializer.new(ErrorMessage.new(
                        "Validation failed: #{message.join(", ")}" ,422))
                        .serialize_json, status:422
  end
end