require 'rails_helper'

describe 'Join game API' do

  before :each do
    @game = create(:game)
    @player = create(:player, game_id: @game.id)
    @game.players << @player
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

  it "allows a player to join a game" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
    json_payload = {
      gameId: @game.id,
      playerName: "George",
      }

      post "/api/v1/join_game", headers: headers, params: json_payload.to_json
      expect(response).to be_successful
      data = JSON.parse(response.body)
      player2 = Player.find_by(name: "George")
      expect(data['playerName']).to eq("George")
      expect(data['gameId']).to eq(@game.id)
      expect(data['playerId']).to eq(player2.id)
      expect(data['gameStatus']).to eq("Game Started")
      #Make sure game started
      @player.reload
      expect(@player.cards.count).to eq(10)
      expect(player2.cards.count).to eq(10)
  end

  it "rejects connections if more then max players join" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
    inital_payload = {
      gameId: @game.id,
      playerName: "George",
    }
    second_payload = {
      gameId: @game.id,
      playerName: "NotGeorge",
    }
    post "/api/v1/join_game", headers: headers, params: inital_payload.to_json
    post "/api/v1/join_game", headers: headers, params: second_payload.to_json
      expect(response).to_not be_successful
      expect(response.status).to eq(406);
      data = JSON.parse(response.body)
      expect(data).to have_key("error")
      #Make sure game only has 2 players
      expect(@game.players.length).to eq(2)
  end

  it "keeps the existing player if they rejoin" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
    inital_payload = {
      gameId: @game.id,
      playerName: "George",
    }
    second_payload = {
      gameId: @game.id,
      playerName: "George",
    }
    third_payload = {
      gameId: @game.id,
      playerName: "George",
    }
    post "/api/v1/join_game", headers: headers, params: inital_payload.to_json
    post "/api/v1/join_game", headers: headers, params: second_payload.to_json
    post "/api/v1/join_game", headers: headers, params: third_payload.to_json
      expect(response).to be_successful
      expect(response.status).to eq(200);
      data = JSON.parse(response.body)
      player2 = Player.find_by(name: "George")
      expect(data['playerName']).to eq("George")
      expect(data['gameId']).to eq(@game.id)
      expect(data['playerId']).to eq(player2.id)
      expect(data['gameStatus']).to eq("Game Started")
      #Make sure game only has 2 players
      expect(@game.players.length).to eq(2)
  end
end
