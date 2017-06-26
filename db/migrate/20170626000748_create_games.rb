class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
    	t.string :status
      t.string :tiles_played, array: true
      t.timestamps
    end
  end
end
