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
    max_players = 2
    #change above variable to allow for more players
    current_player = Player.find_by(name: params['playerName'])
    if game.players.length >= max_players && current_player.nil?
      render json: {error: "Game is full"}, status: 406
    else
      new_player = game.players.create(name: params['playerName']) if current_player.nil?
      game.start if game.game_cards.length == 0 && game.players.length == max_players
      join_info = {
        gameId: game.id,
        playerId: new_player.id,
        playerName: new_player.name,
        gameStatus: "Game Started",
      }
      render json: join_info
    end
  end

  private

  def player_params
    params.require(:newPlayer).permit(:name)
  end
end
