require 'rails_helper'

describe ApplicationCable::Connection, type: :channel do
  it 'successfully connects' do
    game = Game.create
    player = game.players.create(name: 'Tortimer')
    connect('/cable', params: { player_id: player.id })
    expect(connection.current_player).to eq(player)
  end

  it 'rejects connections' do
    expect { connect '/cable' }.to have_rejected_connection
  end
end
