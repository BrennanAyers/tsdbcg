class Player < ApplicationRecord
  belongs_to :game

  def cards
    GameCard.where(player_id: id).joins(:card)
  end

  def buy(card_name)
    game_card = GameCard.joins(:card).where('cards.name': card_name, player_id: nil, game_id: game.id).first
    game_card.update(player_id: id, discarded: true)
  end

  def deck
    cards.where(discarded: false).order(:deck_index)
  end

  def discard
    cards.where(discarded: true).order(:deck_index)
  end

  def reorder_deck(new_order)
    new_order.each_with_index do |id, index|
      cards.find(id).update(discarded: false, deck_index: index + 1)
    end
  end

  def reorder_discard(new_order)
    new_order.each_with_index do |id, index|
      cards.find(id).update(discarded: true, deck_index: index + 1)
    end
  end
end
