require 'rails_helper'

describe 'Buy Card API' do
  before :each do
    @game = create(:game)
    @player = create(:player, game_id: @game.id)
    gold = create(:gold)
    estate = create(:estate)
    create_list(:game_card, 30, game_id: @game.id, card_id: gold.id)
    create_list(:game_card, 8, game_id: @game.id, card_id: estate.id)
  end

  it 'sends a list of things' do
    json_payload = {
      player_id: @player.id,
      bought: {
        "Gold": 1,
        "Estate": 1
      }
    }
    post "/api/v1/games/#{@game.id}/buy_card", params: json_payload.to_json

    expect(response).to be_successful

    expected_response = {
      player_name: @player.name,
      bought: {
        "Gold": 1,
        "Estate": 1
      }
    }

    expect(JSON.parse(response.body)).to eq(expected_response)
  end
end
