class Api::V1::GameStateController < ApplicationController
  def index
    game = Game.find(params[:id])
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
    render json: cards
  end
end
