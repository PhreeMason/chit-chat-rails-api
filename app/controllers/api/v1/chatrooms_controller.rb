class ChatroomsController < ApplicationController
  before_action :authenticate_token!
  
  def index
    chatrooms = Chatroom.all
    render json: chatrooms
  end


end