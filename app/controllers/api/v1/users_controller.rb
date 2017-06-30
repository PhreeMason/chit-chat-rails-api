class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        user: @user.as_json(only: [:id, :username, :email]),
        token: ::Auth.create_token(@user.id)
      }
    else
      render json: { 
        errors: @user.errors 
      }, status: 500
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
