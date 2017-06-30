class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :turn, :tiles_played, :game_players
end
