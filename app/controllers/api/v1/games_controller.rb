class Api::V1::GamesController < ApplicationController
  def create
    game = Game.create
    player = Player.new(name: player_params[:name], game_id: game.id)
    player.save
    render json: {
      playerName: player.name,
      playerId: player.id,
      gameId: game.id
    }, status: 201
  end

  def update
    game_id = (params["gameId"])
    player = Player.find(params["playerId"])
    GameCard.where(id: params['bought'], game_id: game_id).update(player_id: player.id)
    player.reorder_deck(params['deck'])
    player.reorder_discard(params['discard'])
  end

  private

  def player_params
    params.require(:newPlayer).permit(:name)
  end
end
