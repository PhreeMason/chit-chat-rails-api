json.chatrooms @chatrooms do |chatroom|
  json.id chatroom.id
  json.name chatroom.name
  json.members chatroom.chatroom_users.count
  if chatroom.private
    json.dm [chatroom.users[0].username,chatroom.users[1].username] 
  end
end