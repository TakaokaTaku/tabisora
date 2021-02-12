class CreateMemos < ActiveRecord::Migration[6.1]
  def change
    create_table :memos do |t|

      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :memos, [:user_id, :created_at]
  end
end
