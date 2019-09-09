class CreateGameCards < ActiveRecord::Migration[5.2]
  def change
    create_table :game_cards do |t|
      t.references :game, foreign_key: true
      t.references :card, foreign_key: true
      t.bigint :player_id
      t.boolean :trashed, default: false
      t.boolean :discarded, default: false

      t.timestamps
    end
  end
end
