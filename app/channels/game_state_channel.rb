class GameStateChannel < ApplicationCable::Channel
  on_subscribe :broadcast_player_joined

  def subscribed
    ensure_confirmation_sent
    stream_for current_player.game
  end

  private

  def broadcast_message(payload)
    GameStateChannel.broadcast_to current_player.game, message: payload.to_json
  end

  def broadcast_player_joined
    payload = {
      type: 'player-joined',
      data: {
        id: current_player.id,
        name: current_player.name,
        playerList: player_list_generator(current_player.game)
      }
    }
    broadcast_message payload
    begin_game?
  end

  def begin_game?
    max_players = 4
    game = current_player.game
    if game.game_cards.length == 0 && game.players.length == max_players
      game.start
      # game.reload might be needed in production, but seems to be working in tests for the time being
      serialized_game = GameSerializer.new(game)
      payload = {
        type: "game-started",
        data: serialized_game.state
      }
      broadcast_message payload
    end
  end

  def player_list_generator(game)
    game.players.map do |player|
      {
        id: player.id,
        name: player.name
      }
    end
  end
end
