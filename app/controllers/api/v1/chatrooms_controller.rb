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
    @chatroom = Chatroom.find_by(chatroom_params)
    if @chatroom
      if @chatroom.users.include?(current_user)
        render @chatroom
      else
        @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
        @chatroom
      end
    else
      @chatroom = Chatroom.new(chatroom_params)
      if @chatroom.save
        @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create 
        @chatroom
      end  
    end
    
  end

  private

    def chatroom_params
      params.require(:chatroom).permit(:name)
    end

end
