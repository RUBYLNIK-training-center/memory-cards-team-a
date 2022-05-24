class CreateImport < ActiveRecord::Migration[6.1]
  def change
    create_table :imports do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :imports, :user_id
  end
end
