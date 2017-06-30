class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :turn, :tiles_played, :game_players
  has_many :game_players
end
