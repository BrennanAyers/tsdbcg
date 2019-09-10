require 'rails_helper'

describe 'New Game API' do
  before :each do

  end

  it 'sends a player name and receives a newly generated Game' do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
    json_payload = {
      new_player: {
        name: "Test"
      }
    }
    post "/api/v1/games", headers: headers, params: json_payload.to_json

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data["player_name"]).to eq("Test")
    expect(data["player_id"]).to_not be nil
    expect(data["game_id"]).to_not be nil

    expect(Game.last.players.first.name).to eq("Test")
  end
end
