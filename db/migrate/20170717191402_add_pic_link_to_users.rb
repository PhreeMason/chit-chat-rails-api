class AddPicLinkToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :pic_link, :string
  end
end