class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate_token!
  
  def index
    @chatrooms = Chatroom.all
    @messages = DataFormatter.format_chatroom_messages(@chatrooms)
  end
  
  def show
    @chatroom = Chatroom.find[params.id]
  end
end
