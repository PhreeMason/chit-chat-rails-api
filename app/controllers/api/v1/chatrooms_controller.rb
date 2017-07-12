class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate_token!
  
  def index
    chatrooms = Chatroom.all
    render json: {chatroom: chatroom.as_json(only: [:id, :name])}
  end

  def show
    chatroom = Chatroom.find(params[:id])
    messages = chatroom.messages
    chatroom_users = chatroom.chatroom_users

    render json: {
      chatroom: chatroom.as_json(only: [:id, :name]), 
      message: messages.as_json,
      users: chatroom_users.as_json(only: [:user_id, :chatroom_id])
    }
  end



end
