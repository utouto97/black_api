class AddUidToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :uid, :string
    add_index :rooms, :uid, unique: true
  end
end
