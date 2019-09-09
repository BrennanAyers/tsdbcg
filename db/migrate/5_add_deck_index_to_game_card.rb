class AddDeckIndexToGameCard < ActiveRecord::Migration[5.2]
  def change
    add_column :game_cards, :deck_index, :integer
  end
end
