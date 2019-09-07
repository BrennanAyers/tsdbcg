class Player < ApplicationRecord
  belongs_to :game

  def cards
    GameCard.where(player_id: id)
  end

  def buy(card_name)
    game_card = GameCard.joins(:card).where('cards.name': card_name, player_id: nil, game_id: game.id).first
    game_card.update(player_id: id, discarded: true)
  end
end
