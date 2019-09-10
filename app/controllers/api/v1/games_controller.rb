class Api::V1::GamesController < ApplicationController
  def update
    game_id = (params["gameId"])
    player = Player.find(params["playerId"])
    GameCard.where(id: params['bought'], game_id: game_id).update(player_id: player.id)
    player.reorder_deck(params['deck'])
    player.reorder_discard(params['discard'])
  end

  def join
    # require "pry"; binding.pry
    # Player.create(name: params['playerName'], game_id: params['gameId'])
    game = Game.find(params['gameId'])
    new_player = game.players.create(name: params['playerName'])
    # {player_name: "George", player_id: 2, game_id: 1, game_status: "Game Started"}
    join_info = {
      gameId: game.id,
      playerId: new_player.id,
      playerName: new_player.name,
      gameStatus: "Game Started"
    }
    render json: join_info
  end

end
