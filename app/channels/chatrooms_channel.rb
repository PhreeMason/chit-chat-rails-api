class ChatroomsChannel < ApplicationCable::Channel
  
  def subscribed
    stream_from "chatroom: #{params[:id]}"
  end
  
  def send_message(data)
    puts data
    @chatroom = Chatroom.find(data["chatroom_id"])
    message = @chatroom.messages.create(body: data["body"], user: current_user) 
    MessageRelayJob.perform_later(message)
  end

  def unsubscribed
    stop_all_streams
  end
end
