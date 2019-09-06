require "rails_helper"

describe GameChannel do
  setup do
    @game = create(:game)
    player = create(:player, game_id: @game.id)
    gold = create(:gold)
    estate = create(:estate)
    create_list(:game_card, 30, game_id: @game.id, card_id: gold.id)
    create_list(:game_card, 8, game_id: @game.id, card_id: estate.id)
    stub_connection player: player
  end

  it "sends a successful response" do
    subscribe
    expect(subscription).to be_confirmed
  end

  it "Renders Game State" do
    subscribe
    perform :render_game_state, game_id: @game.id
    expect((transmissions.first)).to eq([{
        "name" => "Gold",
        "category" => "Money",
        "cost" => 6,
        # image => "Gold.jpg",
        "victoryPoints" => nil,
        "spendingPower" => 3,
        "countAvailable" => 30
      },
      {
        "name" => "Estate",
        "category" => "Victory",
        "cost" => 2,
        # image => "Estate.jpg",
        "victoryPoints" => 1,
        "spendingPower" => 0,
        "countAvailable" => 8
      }])
  end
end

# [
#   {
#     name: "Village",
#     tags: ["+1 Card", "+2 Actions"],
#     desc: "",
#     type: ["Action"],
#     cost: 3,
#     spendingPower: 0,
#     actionsProvided: 2,
#     cardsToDraw: 1,
#     image: "Village.jpg",
#     id: 1231
#   },
#   {
#     name: "Militia",
#     tags: ["+2 Gold"],
#     desc: "Each other player discards down to 3 cards in his hand.",
#     type: ["Action", "Attack"],
#     cost: 4,
#     spendingPower: 2,
#     buyingPower: 0,
#     actionsProvided: 0,
#     cardsToDraw: 0,
#     image: "Village.jpg",
#     id: 1391
#   },
#   {
#     name: "Smithy",
#     tags: ["+3 Cards"],
#     desc: "",
#     type: ["Action"],
#     cost: 4,
#     spendingPower: 0,
#     buyingPower: 0,
#     actionsProvided: 0,
#     cardsToDraw: 3,
#     image: "Village.jpg",
#     id: 9531
#   },
#   {
#     name: "Market",
#     tags: ["+1 Card", "+1 Action", "+1 Buy", "+1 Gold"],
#     desc: "",
#     type: ["Action"],
#     cost: 5,
#     spendingPower: 1,
#     buyingPower: 1,
#     actionsProvided: 1,
#     cardsToDraw: 1,
#     image: "Village.jpg",
#     id: 1532
#   },
#   {
#     name: "Mine",
#     tags: [],
#     desc:
#       "Trash a treasure Card from your hand. Gain a treasure card costing up to 3 treasure more; put it in your hand.",
#     type: ["Action"],
#     cost: 5,
#     spendingPower: 0,
#     buyingPower: 0,
#     actionsProvided: 0,
#     cardsToDraw: 0,
#     image: "Village.jpg",
#     id: 1522
#   },
#   {
#     name: "Remodel",
#     tags: [],
#     desc:
#       "Trash a card from your hand. Gain a card costing up to 2 treasure more than the trashed card.",
#     type: ["Action"],
#     cost: 4,
#     spendingPower: 0,
#     buyingPower: 0,
#     actionsProvided: 0,
#     cardsToDraw: 0,
#     image: "Village.jpg",
#     id: 3333
#   },
#   {
#     name: "Cellar",
#     tags: ["+1 Action"],
#     desc: "Discard any number of cards. +1 Card per card discarded.",
#     type: ["Action"],
#     cost: 2,
#     spendingPower: 0,
#     buyingPower: 0,
#     actionsProvided: 1,
#     cardsToDraw: 0,
#     image: "Village.jpg",
#     id: 9831
#   },
#   {
#     name: "Moat",
#     tags: ["+2 Cards"],
#     desc:
#       "When another player plays an Attack card, you may reveal this from your hand. If you do, you are unaffected by that attack",
#     type: ["Action", "Reaction"],
#     cost: 2,
#     spendingPower: 0,
#     buyingPower: 0,
#     actionsProvided: 0,
#     cardsToDraw: 2,
#     image: "Village.jpg",
#     id: 1938
#   },
#   {
#     name: "WoodCutter",
#     tags: ["+1 Buy", "+2 Gold"],
#     desc: "",
#     type: ["Action"],
#     cost: 3,
#     spendingPower: 2,
#     buyingPower: 1,
#     actionsProvided: 0,
#     cardsToDraw: 0,
#     image: "Village.jpg",
#     id: 9781
#   },
#   {
#     name: "WorkShop",
#     tags: [],
#     desc: "Gain a card costing up to 4 treasure.",
#     type: ["Action"],
#     cost: 3,
#     spendingPower: 0,
#     buyingPower: 0,
#     actionsProvided: 0,
#     cardsToDraw: 0,
#     image: "Village.jpg",
#     id: 1333
#   },
#   {
#     name: "Gold",
#     type: ["Treasure"],
#     cost: 6,
#     image: "Gold.jpg",
#     spendingPower: 3,
#     id: 1515
#   },
#   {
#     name: "Silver",
#     type: ["Treasure"],
#     cost: 3,
#     image: "Silver.jpg",
#     spendingPower: 2,
#     id: 8923
#   },
#   {
#     name: "Copper",
#     type: ["Treasure"],
#     cost: 0,
#     image: "Copper.jpg",
#     spendingPower: 1,
#     id: 1113
#   },
#   {
#     name: "Estate",
#     type: ["Victory"],
#     cost: 2,
#     image: "Estate.jpg",
#     victoryPoints: 1,
#     id: 6123
#   },
#   {
#     name: "Duchy",
#     type: ["Victory"],
#     cost: 5,
#     image: "Duchy.jpg",
#     victoryPoints: 3,
#     id: 1344
#   },
#   {
#     name: "Province",
#     type: ["Victory"],
#     cost: 8,
#     image: "Province.jpg",
#     victoryPoints: 6,
#     id: 3781
#   }
# ];
