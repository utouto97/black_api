class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :other, foreign_key: { to_table: :users }

      t.timestamps

      t.index [:user_id, :other_id], unique: true
    end
  end
end
