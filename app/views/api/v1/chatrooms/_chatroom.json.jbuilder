json.chatroom do
  json.id @chatroom.id
  json.name @chatroom.name
  json.members @chatroom.chatroom_users.count
	if chatroom.private
    json.dm [chatroom.users[0].username,chatroom.users[1].username] 
  end
end

json.messages @chatroom.messages do |message|
	json.body message.body
	json.user_name message.user_name
	json.time message.created_at
end