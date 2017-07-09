class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :chatroom_users
end
