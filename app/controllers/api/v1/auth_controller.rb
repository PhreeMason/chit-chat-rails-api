class Api::V1::AuthController < ApplicationController
  before_action :authenticate_token!, only: [:refresh]

  def login
    @user = User.find_by(username: params[:user][:username])
    if !@user
      render json: { 
        errors: { Username: [' is invalid!'] }
      }, status: 500
    elsif @user && @user.authenticate(params[:user][:password])
      render @user   
    else
      render json: { 
        errors: { Password: [' is invalid!'] }
      }, status: 500
    end
  end
 
  def refresh
    render @user  
  end
  
end
