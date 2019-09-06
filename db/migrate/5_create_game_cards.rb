class CreateGameCards < ActiveRecord::Migration[5.2]
  def change
    create_table :game_cards do |t|
      t.references :game, foreign_key: true
      t.references :card, foreign_key: true
      t.references :deck, foreign_key: true
      t.boolean :trashed
      t.boolean :discarded

      t.timestamps
    end
  end
end
