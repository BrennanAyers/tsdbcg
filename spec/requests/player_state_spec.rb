require 'rails_helper'

describe 'Player State API' do
  before :each do
    @game = create(:game)
    @player = create(:player, game_id: @game.id)
    @copper = create(:copper)
    silver = create(:silver)
    gold = create(:gold)
    @estate = create(:estate)
    duchy = create(:duchy)
    province = create(:province)
    village = create(:village)
    militia = create(:militia)
    smithy = create(:smithy)
    market = create(:market)
    mine = create(:mine)
    remodel = create(:remodel)
    cellar = create(:cellar)
    moat = create(:moat)
    woodcutter = create(:woodcutter)
    workshop = create(:workshop)
  end

  it 'sends the players current deck and discard' do
    @game.start
    get "/api/v1/games/#{@game.id}/players/#{@player.id}"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['playerId']).to eq(@player.id)
    expect((data['deck']).count).to eq(10)
    expect((data['discard']).count).to eq(0)

    expect(data['deck'].first).to have_key('name')
    expect(data['deck'].first).to have_key('category')
    expect(data['deck'].first).to have_key('cost')
    expect(data['deck'].first).to have_key('victoryPoints')
    expect(data['deck'].first).to have_key('spendingPower')
    expect(data['deck'].first).to have_key('buyingPower')
    expect(data['deck'].first).to have_key('actionsProvided')
    expect(data['deck'].first).to have_key('cardsToDraw')
    expect(data['deck'].first).to have_key('image')
    expect(data['deck'].first).to have_key('desc')
    expect(data['deck'].first).to have_key('tags')
    expect(data['deck'].first).to have_key('id')
    expect(data['deck'].last).to have_key('name')
    expect(data['deck'].last).to have_key('category')
    expect(data['deck'].last).to have_key('cost')
    expect(data['deck'].last).to have_key('victoryPoints')
    expect(data['deck'].last).to have_key('spendingPower')
    expect(data['deck'].last).to have_key('buyingPower')
    expect(data['deck'].last).to have_key('actionsProvided')
    expect(data['deck'].last).to have_key('cardsToDraw')
    expect(data['deck'].last).to have_key('image')
    expect(data['deck'].last).to have_key('desc')
    expect(data['deck'].last).to have_key('tags')
    expect(data['deck'].last).to have_key('id')
  end

  it 'sends the players current deck in draw order' do
    # Set Stable random seed for deck index generation
    srand 12345
    @game.start
    get "/api/v1/games/#{@game.id}/players/#{@player.id}"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    card_name_expectations = [
      @estate.name,
      @copper.name,
      @copper.name,
      @copper.name,
      @copper.name,
      @copper.name,
      @copper.name,
      @estate.name,
      @copper.name,
      @estate.name
    ]
    data['deck'].each_with_index do |card, index|
      expect(card['name']).to eq(card_name_expectations[index])
    end
  end
end
