class Chatroom < ApplicationRecord
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages
  validates :name, presence: true, uniqueness: true

  def user_ids
    self.chatroom_users.map(&:user_id)
  end
end
