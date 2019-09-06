class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def render_game_state(id)
    game = Game.find(id["game_id"])
    ActionCable.server.broadcast 'game_channel', test: 'test'
    cards = []
    game.cards.distinct.select("id","name","category","cost","victory_points","spending_power").each do |card|
      cards << {
        name: card.name,
        category: card.category,
        cost: card.cost,
        victoryPoints: card.victory_points,
        spendingPower: card.spending_power,
        #TODO and player ID null so card not in a deck
        countAvailable: game.game_cards.where(card_id: card.id).count
      }
    end
    transmit(cards)
  end

  def buy_cards(payload)
    # binding.pry
    player = Player.find(payload["player_id"])
    #find first gamecard in table, same id player id null, set to discarded set player id
    payload['bought'].each do |card_name, number_bought|
      number_bought.times do
        player.buy(card_name)
      end
    end
    response = {
        name: player.name,
        bought: {
          "Gold" => 1,
          "Estate" => 1
        }
      }
        transmit(response)
  end
end
