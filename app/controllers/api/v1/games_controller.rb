class Api::V1::GamesController < ApplicationController
  def update
    # require "pry"; binding.pry
    game = Game.find(params["gameId"])
    player = Game.find(params["playerId"])
    # "gameId"=>5, "playerId"=>5, "controller"=>"api/v1/games", "action"=>"update", "game"=>{}} permitted: false>
    # player = Player.find(buy_params[:player_id])
    # if game.id == player.game.id
    #   buy_params[:bought].each do |card_name, num_bought|
    #     num_bought.times do
    #       player.buy(card_name)
    #     end
    #   end
    #   render json: {
    #     player_name: player.name,
    #     bought: buy_params[:bought]
    #   }
    # end
  end

  # def buy_params
  #   params.require(:buy_info).permit(:player_id, bought: {})
  # end
end
