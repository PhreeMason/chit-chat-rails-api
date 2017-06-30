class Api::V1::AuthController < ApplicationController

  def login
    @user = User.find_by(username: params[:user][:username])
    if !@user
      render json: { 
        errors: { username: ['Username is invalid!'] }
      }, status: 500
    elsif @user && @user.authenticate(params[:user][:password])
      render json: {
              user: @user.as_json(only: [:id, :username, :email]),
              token: ::Auth.create_token(@user.id)
            }    
    else
      render json: { 
        errors: { password: ['Password is invalid!'] }
      }, status: 500
    end
  end
 
  def refresh
  
  end
  
end
