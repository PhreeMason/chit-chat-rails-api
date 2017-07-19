class Api::V1::UsersController < ApplicationController
  before_action :authenticate_token!, only: :update

  def create
    @user = User.new(user_params)
    if @user.save
      render @user
    else
      render json: { 
        errors: @user.errors 
      }, status: 500
    end
  end
  
  def update
    user = current_user
    user.update(update_params)
    render @user
  end

  def show
    @user = User.find_by(username: params[:username])
    render @user
  end

  private
    
    def update_params
      params.require(:user).permit(:bio, :pic_link, :location)
    end

    def user_params
      params.require(:user).permit(:username, :password, :email)
    end
end
