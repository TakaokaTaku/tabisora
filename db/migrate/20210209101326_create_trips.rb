class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.text :title
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :trips, [:created_at]
  end
end
