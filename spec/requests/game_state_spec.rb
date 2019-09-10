require 'rails_helper'

describe 'Game State API' do
  before :each do
    @game = create(:game)
    gold = create(:gold)
    copper = create(:copper)
    estate = create(:estate)
    @player = create(:player, game_id: @game.id)
    create_list(:game_card, 3, game_id: @game.id, card_id: estate.id, player_id: @player.id)
    create_list(:game_card, 7, game_id: @game.id, card_id: copper.id, player_id: @player.id)
    create_list(:game_card, 30, game_id: @game.id, card_id: gold.id)
    create_list(:game_card, 8, game_id: @game.id, card_id: estate.id)
  end

  it 'sends the initial game state' do
    get "/api/v1/game_state/#{@game.id}"
    expect(JSON.parse(response.body)).to have_key('tableDeck')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('name')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('category')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('victoryPoints')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('spendingPower')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('buyingPower')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('actionsProvided')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('cardsToDraw')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('image')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('desc')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('tags')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('countAvailable')
    expect(JSON.parse(response.body)["tableDeck"].first).to have_key('id_list')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('name')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('category')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('victoryPoints')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('spendingPower')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('buyingPower')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('actionsProvided')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('cardsToDraw')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('image')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('desc')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('tags')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('countAvailable')
    expect(JSON.parse(response.body)["tableDeck"].last).to have_key('id_list')
    expect(JSON.parse(response.body)).to have_key('playerOrder')
    expect(JSON.parse(response.body)).to have_key('playerInfo')
    expect(JSON.parse(response.body)["playerInfo"]).to have_key(@player.name)
    expect(JSON.parse(response.body)["playerInfo"][@player.name]).to have_key("deckSize")
    expect(JSON.parse(response.body)["playerInfo"][@player.name]).to have_key("topCardDiscard")
    expect(JSON.parse(response.body)["playerInfo"][@player.name]).to have_key("handSize")
    data = JSON.parse(response.body)
    expect(data['activePlayerName']).to eq(@player.name)
    expect(data['activePlayerId']).to eq(@player.id)
  end
end
