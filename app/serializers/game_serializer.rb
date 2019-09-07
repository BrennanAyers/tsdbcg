class GameSerializer
  def initialize(game)
    @game = game
  end

  def cards
    @game.cards.distinct.select("id","name","category","cost","victory_points","spending_power").map do |card|
      {
        name: card.name,
        category: card.category,
        cost: card.cost,
        victoryPoints: card.victory_points,
        spendingPower: card.spending_power,
        countAvailable: @game.game_cards.where(card_id: card.id).count
      }
    end
  end
end
