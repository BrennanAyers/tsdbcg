class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :type
      t.integer :cost
      t.integer :victory_points
      t.integer :spending_power

      t.timestamps
    end
  end
end
