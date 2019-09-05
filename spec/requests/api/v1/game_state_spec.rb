require "rails_helper"

describe "Game State API" do
  setup do
    @game = create(:game)
    gold = create_list(:gold, 30)
    estates = create_list(:estate, 8)
    @game.cards += gold
    @game.cards += estates
  end

  it "sends a successful response" do
    get "/api/v1/game_state"
    expect(response).to be_successful
  end

  it "sends all cards in the game" do
    get "/api/v1/game_state"
    game_state = JSON.parse response
    require 'pry'; binding.pry
    # expect(game_state)
  end
end
