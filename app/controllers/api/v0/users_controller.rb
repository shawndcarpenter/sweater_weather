class  Api::V0::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def create
    
    if !params[:password] || !params[:password_confirmation]
      missing_data_response(params)
    elsif params[:password_confirmation] != params[:password]
      passwords_must_match_response
    else
      user = User.create!(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      user.create_api_key
      render json: UserSerializer.new(user), status: 201
    end
  end

  private
  def invalid_response(exception)
    if exception.message.include?("Validation failed")
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .serialize_json, status: 400
    else
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422))
      .serialize_json, status: :not_found
    end
  end

  def passwords_must_match_response
    render json: ErrorSerializer.new(ErrorMessage.new("Password and password confirmation must match", 400))
    .serialize_json, status: 400
  end

  def missing_data_response(params)
    if !params[:password] && !params[:password_confirmation]
      render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: Password can't be blank, password confirmation can't be blank", 400))
      .serialize_json, status: 400
    elsif !params[:password] 
      render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: Password can't be blank", 400))
      .serialize_json, status: 400
    elsif !params[:password_confirmation]
      render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: Password confirmation can't be blank", 400))
      .serialize_json, status: 400
    end
  end
end