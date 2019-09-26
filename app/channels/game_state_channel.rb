class GameStateChannel < ApplicationCable::Channel
  def subscribed
    ensure_confirmation_sent
    stream_for current_player.game

    payload = {
      type: 'player-joined',
      data: {
        id: current_player.id,
        name: current_player.name,
        playerList: player_list_generator(current_player.game)
      }
    }
    broadcast_message payload
  end

  private

  def broadcast_message(payload)
    GameStateChannel.broadcast_to current_player.game, message: payload.to_json
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
