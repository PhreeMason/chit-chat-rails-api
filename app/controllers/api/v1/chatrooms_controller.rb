class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate_token!
  
  def index
    @chatrooms = current_user.chatrooms.all 
    @messages = DataFormatter.format_chatroom_messages(@chatrooms)
  end
  
  def show
    @chatroom = Chatroom.find[params.id]
    @messages = DataFormatter.format_chatroom_messages([@chatroom])
  end

  def create
    chatroom = Chatroom.join_room(chatroom_params, current_user)
    if chatroom
      @chatrooms = current_user.chatrooms.all 
      @messages = DataFormatter.format_chatroom_messages(@chatrooms)
    else
      @chatroom = Chatroom.new(chatroom_params)
      @chatroom.users << current_user
      if @chatroom.save
        @chatrooms = current_user.chatrooms.all 
        @messages = DataFormatter.format_chatroom_messages(@chatrooms)
      else
        render json: { 
          errors: @chatroom.errors 
        }, status: 500 
      end  
    end 

  end

  def direct_message
    @user2 = User.find_by(dm_params)
    if @user2
      name = "#{current_user.username}-#{@user2.username}"
      @chatroom = Chatroom.new(name: name, private: true)
      @chatroom.users << current_user
      @chatroom.users << @user2
      render @chatroom if @chatroom.save
    else
      render json: { 
        errors: {error: 'User not found!'} 
      }, status: 500 
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
