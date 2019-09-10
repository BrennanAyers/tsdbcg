class Game < ApplicationRecord
has_many :players
has_many :game_cards
has_many :cards, through: :game_cards

  def start
    copper = Card.find_by(name: "Copper")
    estate = Card.find_by(name: "Estate")
    const_deck_indexes = [1,2,3,4,5,6,7,8,9,10]
    players.each do |player|
      deck_indexes = const_deck_indexes
      7.times do
        GameCard.create(card_id: copper.id, game_id: id, player_id: player.id, deck_index: deck_indexes.shuffle!.pop)
      end
      3.times do
        GameCard.create(card_id: estate.id, game_id: id, player_id: player.id, deck_index: deck_indexes.shuffle!.pop)
      end
    end
    60.times do
      GameCard.create(card_id: copper.id, game_id: id)
    end
    8.times do
      GameCard.create(card_id: estate.id, game_id: id)
    end
  end

  def current_player
    Player.find(players.pluck(:id)[turn % players.count])
  end

  def player_order
    #todo - update to track player order
    return players
  end
end
