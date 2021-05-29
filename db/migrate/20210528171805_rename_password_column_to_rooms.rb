class RenamePasswordColumnToRooms < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :password, :password_digest
  end
end
