class Player < ApplicationRecord
  belongs_to :game

  def cards
    GameCard.where("player_id": id)
  end

  def buy(card_name)
    game_card = GameCard.joins(:card).where('cards.name': card_name, player_id: nil).first
    game_card.update(player_id: id, discarded: true)
  end

  def fetch_top_discard
    #todo - Update this on each end_turn -
    top_card = GameCard
    .joins(:card)
    .select("cards.name, game_cards.*")
    .where("game_cards.player_id": id, "game_cards.discarded": true)
    .first
    return top_card.name if top_card
    return nil
  end

  def fetch_hand_size
    #todo - Include way to modify this on militia hit
    return 5
  end
end
