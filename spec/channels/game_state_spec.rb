require "rails_helper"

describe GameChannel do
  setup do
    @game = create(:game)
    player = create(:player, game_id: @game.id)
    gold = create_list(:gold, 30)
    estates = create_list(:estate, 8)
    @game.cards += gold
    @game.cards += estates
    stub_connection player: player
  end

  it "sends a successful response" do
    subscribe
    expect(subscription).to be_confirmed
  end

  it "Renders Game State" do
    subscribe
    perform :render_game_state
    expect(transmissions.first[:test]).to eq("test")
  end
end
