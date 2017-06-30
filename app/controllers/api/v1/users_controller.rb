class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
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
