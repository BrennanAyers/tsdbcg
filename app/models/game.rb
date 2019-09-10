class Game < ApplicationRecord
has_many :players
has_many :game_cards
has_many :cards, through: :game_cards

  def start
    set_player_deck(self.players)
    set_table_deck
  end

  def player_order
    #todo - update to track player order
    return players
  end

  private

  def set_table_deck
    create_card("Copper", 60)
    create_card("Silver", 40)
    create_card("Gold", 30)
    create_card("Estate", 8)
    create_card("Duchy", 8)
    create_card("Province", 8)
    create_card("Village", 10)
    create_card("Militia", 10)
    create_card("Smithy", 10)
    create_card("Market", 10)
    create_card("Mine", 10)
    create_card("Remodel", 10)
    create_card("Cellar", 10)
    create_card("Moat", 10)
    create_card("Woodcutter", 10)
    create_card("Workshop", 10)
  end

  def create_card(card_name, number)
    card = Card.find_by(name: card_name)
      number.times do
        GameCard.create(card_id: card.id, game_id: id)
      end
    end
  end

  def set_player_deck(players)
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
  end
