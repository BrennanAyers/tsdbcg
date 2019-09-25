require 'rails_helper'

describe GameStateChannel, type: :channel do
  let(:game){Game.create}

  before(:each) do
    @player = game.players.create(name: 'Testerino')
    stub_connection current_player: @player
  end

  it 'subscribes to a game' do
    subscribe(game_id: @player.game.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(game)
  end
end
