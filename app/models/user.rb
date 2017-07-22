class User < ApplicationRecord
	has_secure_password
  validates :username, presence: true 
  validates_uniqueness_of :username, :case_sensitive => false
  validates :email, presence: true 
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  has_many :game_players
  has_many :games, through: :game_players 
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users 
  has_many :messages
end
