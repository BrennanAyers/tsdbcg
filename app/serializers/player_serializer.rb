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
        victoryPoints: card.card.victory_points,
        spendingPower: card.card.spending_power,
        buyingPower: card.card.buying_power,
        actionsProvided: card.card.actions_provided,
        cardsToDraw: card.card.cards_to_draw,
        image: card.card.image,
        desc: card.card.desc,
        tags: card.card.tags.split(','),
        id: card.id
        }},
      discard: @player.discard.map {|card| {
        name: card.card.name,
        category: card.card.category.split(','),
        cost: card.card.cost,
        victoryPoints: card.card.victory_points,
        spendingPower: card.card.spending_power,
        buyingPower: card.card.buying_power,
        actionsProvided: card.card.actions_provided,
        cardsToDraw: card.card.cards_to_draw,
        image: card.card.image,
        desc: card.card.desc,
        tags: card.card.tags.split(','),
        id: card.id
        }}
    }
  end
end
