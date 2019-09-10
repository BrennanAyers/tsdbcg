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
      newPlayer: {
        name: "Test"
      }
    }
    post "/api/v1/games", headers: headers, params: json_payload.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    data = JSON.parse(response.body)

    expect(data["playerName"]).to eq("Test")
    expect(data["playerId"]).to_not be nil
    expect(data["gameId"]).to_not be nil

    expect(Game.last.players.first.name).to eq("Test")
  end
end
