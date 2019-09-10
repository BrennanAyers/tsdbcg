class Card < ApplicationRecord
  has_many :game_cards
  has_many :games, through: :game_cards

  def fetch_card_ids
    GameCard.select(:id).where(card_id: id, player_id: nil).map{|card| card.id}
  end
end
