class Api::V1::GameStateController < ApplicationController
  def index
    game = Game.find(params[:id])
    serialized_game = GameSerializer.new(game)
    render json: serialized_game.state
  end
end
