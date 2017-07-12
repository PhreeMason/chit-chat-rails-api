class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  def user_name
    self.user.username
  end
end
