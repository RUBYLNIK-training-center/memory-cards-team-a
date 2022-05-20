class AddBoardIdToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :board_id, :integer
    add_index :cards, :board_id
  end
end
