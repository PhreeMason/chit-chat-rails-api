json.chatrooms @chatrooms do |chatroom|
  json.id chatroom.id
  json.name chatroom.name
  json.members chatroom.chatroom_users.count
  json.messages chatroom.messages do |message|
    json.body message.body
    json.chatroom_id message.chatroom_id 
    json.user_name message.user.username
  end 
end
