class AddEndTilesToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :end_tiles, :integer, array: true, default: []
  end
end
