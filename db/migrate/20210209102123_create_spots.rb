class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :address
      t.float :latitudo
      t.float :longitude
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
