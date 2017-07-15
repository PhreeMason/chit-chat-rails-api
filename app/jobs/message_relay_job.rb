class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast("chatroom: #{message.chatroom_id}",
      Api::V1::MessagesController.render(message)
    )
  end
end
