class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.text :title
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :trips, [:user_id, :created_at]
  end
end
