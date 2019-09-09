class Game < ApplicationRecord
has_many :players
has_many :game_cards
has_many :cards, through: :game_cards

  def start
    copper = Card.find_by(name: "Copper")
    estate = Card.find_by(name: "Estate")
    players.each do |player|
      7.times do
        GameCard.create(card_id: copper.id, game_id: id, player_id: player.id)
      end
      3.times do
        GameCard.create(card_id: estate.id, game_id: id, player_id: player.id)
      end
    end
    60.times do
      GameCard.create(card_id: copper.id, game_id: id)
    end
    8.times do
      GameCard.create(card_id: estate.id, game_id: id)
    end
  end

  def player_order
    #todo - update to track player order
    return players
  end
end
