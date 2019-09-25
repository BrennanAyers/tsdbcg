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

  it 'broadcasts player info when one player subscribes' do
    expect{ subscribe }.to have_broadcasted_to(game)
      .from_channel(GameStateChannel)
      .with{ |data|
        message = JSON.parse(data[:message], symbolize_names: true)
        expect(message[:type]).to eq('player-joined')
        payload = message[:data]
        expect(payload[:id]).to eq(@player.id)
        expect(payload[:name]).to eq(@player.name)
      }
  end
end
