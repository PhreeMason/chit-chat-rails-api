class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_token!

  end

  private

    def message_params
      params.require(:message).permit(:body, :chatroom_id)
    end
end
