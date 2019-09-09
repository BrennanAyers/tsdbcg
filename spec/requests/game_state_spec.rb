require 'rails_helper'

describe 'Game State API' do
  before :each do
    @game = create(:game)
    gold = create(:gold)
    estate = create(:estate)
    create_list(:game_card, 30, game_id: @game.id, card_id: gold.id)
    create_list(:game_card, 8, game_id: @game.id, card_id: estate.id)
  end

  it 'sends the initial game state' do
    get "/api/v1/game_state/#{@game.id}"
    expect(JSON.parse(response.body)).to eq([{
      "name" => "Gold",
      "category" => "Money",
      "cost" => 6,
      "victoryPoints" => nil,
      "spendingPower" => 3,
      "countAvailable" => 30
    },
    {
      "name" => "Estate",
      "category" => "Victory",
      "cost" => 2,
      "victoryPoints" => 1,
      "spendingPower" => nil,
      "countAvailable" => 8
    }])
  end
end
