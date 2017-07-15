class DataFormatter 
  
  def self.format_chatroom_messages(chatrooms)
    messages = {}
    chatrooms.each do |chatroom|
      messages[chatroom.id] = chatroom.messages.map do  |message|
        {body: message.body, user_name: message.user_name}
      end
    end
    messages  
  end

end
