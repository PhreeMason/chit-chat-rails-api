class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate_token!
  
  def index
    @chatrooms = Chatroom.all
  end
  
  def show
    @chatroom = Chatroom.find[params.id]
  end
end
