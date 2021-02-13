class AddAddressToMemos < ActiveRecord::Migration[6.1]
  def change
    add_column :memos, :address,   :string
    add_column :memos, :latitude,  :float
    add_column :memos, :longitude, :float
  end
end
