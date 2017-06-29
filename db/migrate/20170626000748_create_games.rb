class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
    	t.string :status
      t.string :tiles_played, array: true, default: []
      t.integer :turn
      t.string :end_tiles, array: true, default: [] 
      t.timestamps
    end
  end
end
