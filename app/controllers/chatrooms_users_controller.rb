class ChatroomUsersController < ApplicationController
  before_action :authenticate_token!
  before_action :set_chatroom

  def create
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
  end
  
  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
  end
  
  private 
  
    def set_chatroom
      @chat_room = Chatroom.find(params[:chatroom_id])
    end

end
