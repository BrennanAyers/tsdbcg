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
        countAvailable: game.game_cards.where(card_id: card.id).count
      }
    end
    transmit(cards)
  end
end
