require 'rails_helper'

describe 'Game State API' do
  before :each do
    @game = create(:game)
    gold = create(:gold)
    copper = create(:copper)
    estate = create(:estate)
    player = create(:player, game_id: @game.id)
    create_list(:game_card, 3, game_id: @game.id, card_id: estate.id, player_id: player.id)
    create_list(:game_card, 7, game_id: @game.id, card_id: copper.id, player_id: player.id)
    create_list(:game_card, 30, game_id: @game.id, card_id: gold.id)
    create_list(:game_card, 8, game_id: @game.id, card_id: estate.id)
  end

  it 'sends the initial game state' do
    get "/api/v1/game_state/#{@game.id}"
    # require 'pry'; binding.pry
    expect(JSON.parse(response.body)).to eq("game_cards" =>
    [{
      "name" => "Gold",
      "category" => "Money",
      "cost" => 6,
      "victoryPoints" => nil,
      "spendingPower" => 3,
      "countAvailable" => 30
    },
    {
      "name" => "Copper",
      "category" => "Money",
      "cost" => 0,
      "victoryPoints" => nil,
      "spendingPower" => 1,
      "countAvailable" => 0
    },
    {
      "name" => "Estate",
      "category" => "Victory",
      "cost" => 2,
      "victoryPoints" => 1,
      "spendingPower" => nil,
      "countAvailable" => 8
    }],
    "player_order" => ["MyString"],
    "player_info" => {"MyString" =>
      { "deckSize" => 10,
        "topCardDiscard" => nil,
        "handSize" => 5
      }
    }
  )
  end
end
