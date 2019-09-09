class GameSerializer
  def initialize(game)
    @game = game
  end

  def state
    card_arr = @game.cards.distinct.select("id","name","category","cost","victory_points","spending_power").map do |card|
      {
        name: card.name,
        category: card.category,
        cost: card.cost,
        victoryPoints: card.victory_points,
        spendingPower: card.spending_power,
        countAvailable: @game.game_cards.where(card_id: card.id, player_id: nil).count
      }
    end
    players = @game.player_order
    player_names = players.map {|player| player.name}
    player_info_hash = {}
    players.each do |player|
      player_info_hash[player.name] = {
        deckSize: player.cards.length,
        topCardDiscard: player.fetch_top_discard,
        handSize: player.fetch_hand_size
      }
    end
    return {
      game_cards: card_arr,
      player_order: player_names,
      player_info: player_info_hash
    }
  end
end
