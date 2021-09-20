class AddRequirePasswordToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :require_password, :boolean
  end
end
