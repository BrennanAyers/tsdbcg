
# I should be able to POST request 'api/v1/join_game'
#
# Request:
# POST /api/v1/join_game
# BODY: {player_name: "George", game_id: 1}
# Response:
# BODY: {player_name: "George", player_id: 2, game_id: 1, game_status: "Game Started"}

require 'rails_helper'

describe 'Join game API' do

  before :each do
    @game= create(:game)
    @player =(:player, game_id: @game.id)
    @game.players << @player
    @copper = create(:copper)
    @estate = create(:estate)
    # @game.start
  end

  it "allows a player to join a game" do 
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
    json_payload = {
      gameId: @game.id,
      playerName: @player.id,
      }

      post "/api/v1/endturn", headers: headers, params: json_payload.to_json

      expect(response).to be_successful

  end

end
