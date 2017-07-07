class MessageSerializer < ActiveModel::Serializer
  attributes :user_id, :chatroom_id, :body
end
