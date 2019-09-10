class Api::V1::GamesController < ApplicationController
  def new
    game = Game.create
    player = Player.new(name: params[:player_name], game_id: game.id)
    player.save
    render json: {
      player_name: player.name,
      player_id: player.id,
      game_id: game.id
    }
  end

  def update
    game_id = (params["gameId"])
    player = Player.find(params["playerId"])
    GameCard.where(id: params['bought'], game_id: game_id).update(player_id: player.id)
    player.reorder_deck(params['deck'])
    player.reorder_discard(params['discard'])
  end
end
