require 'rails_helper'

describe 'Buy Card API' do
  before :each do
    @game = create(:game)
    @player = create(:player, game_id: @game.id)
    @game.players << @player
    @copper = create(:copper)
    @estate = create(:estate)
    @game.start
  end


# deck: [ ordered array cards ids],
# bought: [array ids ]
# discard: [ordered array card ids]

  it 'sends a list of things' do
    gc1 = @game.game_cards[-1]
    gc2 = @game.game_cards[-2]
    gc3 = @game.game_cards[-3]
    pc1, pc2, pc3, pc4, pc5, pc6, pc7, pc8, pc9, pc10 = @player.cards
    # require "pry"; binding.pry
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
    json_payload = {
      gameId: @game.id,
      playerId: @player.id,
      deck: [pc1.id, pc2.id, pc3.id, pc7.id, pc8.id],
      bought: [gc1.id, gc2.id, gc3.id],
      discard: [pc4.id, pc5.id, gc2.id, gc3.id, pc10.id, pc9.id, pc6.id, gc1.id]
      }

    post "/api/v1/endturn", headers: headers, params: json_payload.to_json
#Assigns bought cards to player
    expect(response).to be_successful
    expect(gc1.player_id).to eq(@player.id)
    expect(gc2.player_id).to eq(@player.id)
    expect(gc3.player_id).to eq(@player.id)
  end
end
