class PlayerSerializer
  def initialize(player)
    @player = player
  end

  def cards
    {
      playerId: @player.id,
      deck: @player.deck.map {|card| {
        name: card.card.name,
        category: card.card.category.split(','),
        cost: card.card.cost,
        spendingPower: card.card.spending_power,
        victoryPoints: card.card.victory_points,
        image: "#{card.card.name}.img",
        id: card.id
        }},
      discard: @player.discard.map {|card| {
        name: card.card.name,
        category: card.card.category.split(','),
        cost: card.card.cost,
        spendingPower: card.card.spending_power,
        victoryPoints: card.card.victory_points,
        image: "#{card.card.name}.img",
        id: card.id
        }}
    }
  end
end
