class AddDeckToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_reference :players, :deck, foreign_key: true
  end
end
