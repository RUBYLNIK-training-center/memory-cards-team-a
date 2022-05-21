class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :boards, :user_id
  end
end
