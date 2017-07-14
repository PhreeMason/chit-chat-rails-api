class Api::V1::ChatroomUsersController < ApplicationController
  before_action :authenticate_token!
  before_action :set_chatroom

  def create
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
    render @chatroom
  end
  
  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
    render json: {message: 'You have left the chatroom'}
  end
  
  private 
  
    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

end
