require 'rails_helper'

describe 'Player State API' do
  before :each do
    @game = create(:game)
    @player = create(:player, game_id: @game.id)
    @gold = create(:copper)
    @estate = create(:estate)
    @game.start
  end

  it 'sends the players current deck and discard' do
    get "/api/v1/games/#{@game.id}/players/#{@player.id}"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['playerId']).to eq(@player.id)
    expect((data['deck']).count).to eq(10)
    expect((data['discard']).count).to eq(0)

    expect(data['deck'].first).to have_key('name')
    expect(data['deck'].first).to have_key('category')
    expect(data['deck'].first).to have_key('cost')
    expect(data['deck'].first).to have_key('spendingPower')
    expect(data['deck'].first).to have_key('victoryPoints')
    expect(data['deck'].first).to have_key('image')
    expect(data['deck'].first).to have_key('id')
    expect(data['deck'].last).to have_key('name')
    expect(data['deck'].last).to have_key('category')
    expect(data['deck'].last).to have_key('cost')
    expect(data['deck'].last).to have_key('spendingPower')
    expect(data['deck'].last).to have_key('victoryPoints')
    expect(data['deck'].last).to have_key('image')
    expect(data['deck'].last).to have_key('id')
  end
end
