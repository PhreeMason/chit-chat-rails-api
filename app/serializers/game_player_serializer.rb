class GamePlayerSerializer < ActiveModel::Serializer
  attributes :game_id, :user_id, :player_order, :tiles
end