class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate_token!
  
  def index
    chatrooms = Chatroom.all
    render json: chatrooms.as_json(
      {only: [:id, :name],
      include: {chatroom_users: {only: [:user_id]}}}
    )  
  end

end
