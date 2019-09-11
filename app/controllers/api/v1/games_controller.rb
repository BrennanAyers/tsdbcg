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
    game = (Game.find(params["gameId"]))
    player = Player.find(params["playerId"])
    GameCard.where(id: params['bought'], game_id: game.id).update(player_id: player.id)
    player.reorder_deck(params['deck'])
    game.turn += 1
    game.save
    player.reorder_discard(params['discard'])
    render json: {"Message": "Player #{player.name} turn ended"}, status: 200
  end

  def join
    game = Game.find(params['gameId'])
    render json: {error: "Game is full"} if game.players.length == 4
    new_player = game.players.create(name: params['playerName'])
    join_info = {
      gameId: game.id,
      playerId: new_player.id,
      playerName: new_player.name,
    }
    render json: join_info
  end

  def start
    game = Game.find(params['gameId'])
    game.start
    serialized_game = GameSerializer.new(game)
    render json: serialized_game.state
  end

  private

  def player_params
    params.require(:newPlayer).permit(:name)
  end
end
