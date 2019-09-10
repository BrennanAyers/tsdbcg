class GameSerializer
  def initialize(game)
    @game = game
  end

  def state
    card_arr = @game.cards.distinct.map do |card|
      {
        name: card.name,
        category: card.category.split(','),
        cost: card.cost,
        victoryPoints: card.victory_points,
        spendingPower: card.spending_power,
        buyingPower: card.buying_power,
        actionsProvided: card.spending_power,
        cardsToDraw: card.cards_to_draw,
        image: card.image,
        desc: card.desc,
        tags: card.tags.split(','),
        countAvailable: @game.game_cards.where(card_id: card.id, player_id: nil).count,
        id_list: card.fetch_card_ids
      }
    end
    players = @game.players
    current_player = @game.current_player
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
      tableDeck: card_arr,
      activePlayerName: current_player.name,
      activePlayerId: current_player.id,
      playerOrder: player_names,
      playerInfo: player_info_hash
    }
  end
end
