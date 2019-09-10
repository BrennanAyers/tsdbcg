class AddTurnToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :turn, :integer, default: 0
  end
end
