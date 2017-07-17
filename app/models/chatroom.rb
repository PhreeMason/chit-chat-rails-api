class Chatroom < ApplicationRecord
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages
  validates :name, presence: true, uniqueness: true
  validates :chatroom_users, length: { maximum: 2, too_long: "This is a private chat %{count} is the maximum allowed"}, if: :private
  validates :name, length: { minimum: 3 }

  def user_ids
    self.chatroom_users.map(&:user_id)
  end
end
