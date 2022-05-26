class AddConfidenceLevelToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :confidence_level, :integer, default: 0
  end
end
