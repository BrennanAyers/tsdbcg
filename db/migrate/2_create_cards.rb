class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :category
      t.integer :cost
      t.integer :victory_points, default: 0
      t.integer :spending_power, default: 0

      t.timestamps
    end
  end
end
