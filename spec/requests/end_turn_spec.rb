require 'rails_helper'

describe 'End turn API' do
  #extra games to ensure we pull from right game
  before :each do
    @game, @g2 = create_list(:game, 2)
    @player = create(:player, game_id: @game.id)
    @player3 = create(:player, game_id: @game.id)
    @player2 = create(:player, game_id: @g2.id)
    @game.players << @player
    @game.players << @player3
    @g2.players << @player2
    @copper = create(:copper)
    @estate = create(:estate)
    @game.start
  end

  it 'sends a list of things' do
    gc1 = @game.game_cards[-1]
    gc2 = @game.game_cards[-2]
    gc3 = @game.game_cards[-3]

    pc1, pc2, pc3, pc4, pc5, pc6, pc7, pc8, pc9, pc10 = @player.cards
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

      expect(@game.current_player).to eq(@player)
    post "/api/v1/endturn", headers: headers, params: json_payload.to_json

    expect(response).to be_successful
    #Assigns bought cards to player
    [gc1,gc2,gc3].map(&:reload)
    expect(gc1.player_id).to eq(@player.id)
    expect(gc2.player_id).to eq(@player.id)
    expect(gc3.player_id).to eq(@player.id)

    # Sets discarded false and updates position
    [pc1, pc2, pc3, pc7, pc8].map(&:reload)
    [pc1, pc2, pc3, pc7, pc8].each_with_index do | game_card, i|
      expect(game_card.discarded).to eq(false)
      expect(game_card.deck_index).to eq(i + 1)
    end

    # Sets discarded true and updates position
    [pc4, pc5, gc2, gc3, pc10, pc9, pc6, gc1].map(&:reload)
    [pc4, pc5, gc2, gc3, pc10, pc9, pc6, gc1].each_with_index do | game_card, i|
      expect(game_card.discarded).to eq(true)
      expect(game_card.deck_index).to eq(i + 1)
    end
    #Changes player
    @game.reload
    require "pry"; binding.pry
      expect(@game.current_player).to eq(@player3)
  end
end
