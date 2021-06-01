class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :content

      t.timestamps
      t.index [:user_id, :room_id], unique: false
    end
  end
end
