class CreateGamePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :game_players do |t|
    	t.belongs_to :game
    	t.belongs_to :user 
    	t.integer :player_order 
    	t.string :tiles, array: true 
    end
  end
end
