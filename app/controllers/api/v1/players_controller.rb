class Api::V1::PlayersController < ApplicationController
  def show
    player = Player.find(params[:player_id])
    render json: PlayerSerializer.new(player).cards
  end
end
