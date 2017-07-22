class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate_token!
  
  def index
    @chatrooms = current_user.chatrooms.all
  end

  def create
    @chatroom = Chatroom.find_by(chatroom_params)
    if @chatroom
      @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
      render @chatroom
    else
      @chatroom = Chatroom.new(chatroom_params)
      @chatroom.users << current_user
      if @chatroom.save
        render @chatroom 
      else
        render json: { 
          errors: @chatroom.errors 
        }, status: 500 
      end  
    end 
  end

  def direct_message
    @user2 = User.find_by(dm_params)
    @chatroom=current_user.chatrooms.where(private: true).detect{|room| room.users.include?(@user2)}
    if @user2 && @chatroom
      render @chatroom
    else
      name = SecureRandom.urlsafe_base64
      @chatroom = Chatroom.new(name: name, private: true)
      @chatroom.users << current_user
      @chatroom.users << @user2
      if @chatroom.save
        render @chatroom
      else
        render json: { 
          errors: @chatroom.errors 
        }, status: 500 
      end
    end
  end



  private

    def dm_params
      params.require(:user).permit(:username)
    end

    def chatroom_params
      params.require(:chatroom).permit(:name)
    end

end
