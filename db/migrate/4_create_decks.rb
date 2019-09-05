class CreateDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
