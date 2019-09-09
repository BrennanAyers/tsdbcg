class Game < ApplicationRecord
  has_many :players
  has_many :game_cards
  has_many :cards, through: :game_cards

  def player_order
    #todo - update to track player order
    return players
  end
end
