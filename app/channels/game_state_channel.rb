class GameStateChannel < ApplicationCable::Channel
  def subscribed
    ensure_confirmation_sent
    stream_for current_player.game

    payload = { message: 'Player Joined' }
    broadcast_message payload
  end

  private

  def broadcast_message(payload)
    GameStateChannel.broadcast_to current_player.game, message: payload.to_json
  end
end
