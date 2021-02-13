class AddContentToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :content, :text
  end
end
