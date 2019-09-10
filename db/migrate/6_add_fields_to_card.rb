class AddFieldsToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :buying_power, :integer
    add_column :cards, :actions_provided, :integer
    add_column :cards, :cards_to_draw, :integer
    add_column :cards, :image, :string
    add_column :cards, :desc, :string
    add_column :cards, :tags, :string
  end
end
