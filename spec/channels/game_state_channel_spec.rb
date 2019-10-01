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

  it 'includes a list of all currently joined players when broadcasting a player joining' do
    subscribe

    second_player = game.players.create(name: 'Johnson Johnsonson')
    stub_connection current_player: second_player

    expect{ subscribe }.to have_broadcasted_to(game)
      .from_channel(GameStateChannel)
      .with{ |data|
        message = JSON.parse(data[:message], symbolize_names: true)
        expect(message[:type]).to eq('player-joined')
        payload = message[:data]
        players = payload[:playerList]
        player_ids = []
        expect(players).to be_instance_of(Array)
        players.each do |player|
          expect(player).to have_key(:id)
          expect(player).to have_key(:name)
          player_ids << player[:id]
        end

        expect(player_ids).to include(@player.id)
        expect(player_ids).to include(second_player.id)
      }
  end

  it 'broadcasts game information when enough players join and game starts' do
    create_cards

    subscribe

    second_player = game.players.create(name: 'Johnson Johnsonson')
    stub_connection current_player: second_player

    subscribe

    third_player = game.players.create(name: 'Don Donsonson')
    stub_connection current_player: third_player

    subscribe

    fourth_player = game.players.create(name: 'Sean Seansonson')
    stub_connection current_player: fourth_player

    expect{ subscribe }.to have_broadcasted_to(game)
      .from_channel(GameStateChannel)
      .twice
      .with{ |data|
        message = JSON.parse(data[:message], symbolize_names: true)
        unless message[:type] == 'player-joined'
          expect(message[:type]).to eq('game-started')
          payload = message[:data]
          expect(payload).to have_key(:tableDeck)
          expect(payload[:tableDeck].first).to have_key(:name)
          expect(payload[:tableDeck].first).to have_key(:category)
          expect(payload[:tableDeck].first).to have_key(:victoryPoints)
          expect(payload[:tableDeck].first).to have_key(:spendingPower)
          expect(payload[:tableDeck].first).to have_key(:buyingPower)
          expect(payload[:tableDeck].first).to have_key(:actionsProvided)
          expect(payload[:tableDeck].first).to have_key(:cardsToDraw)
          expect(payload[:tableDeck].first).to have_key(:image)
          expect(payload[:tableDeck].first).to have_key(:desc)
          expect(payload[:tableDeck].first).to have_key(:tags)
          expect(payload[:tableDeck].first).to have_key(:countAvailable)
          expect(payload[:tableDeck].first).to have_key(:id_list)
          expect(payload[:tableDeck].last).to have_key(:name)
          expect(payload[:tableDeck].last).to have_key(:category)
          expect(payload[:tableDeck].last).to have_key(:victoryPoints)
          expect(payload[:tableDeck].last).to have_key(:spendingPower)
          expect(payload[:tableDeck].last).to have_key(:buyingPower)
          expect(payload[:tableDeck].last).to have_key(:actionsProvided)
          expect(payload[:tableDeck].last).to have_key(:cardsToDraw)
          expect(payload[:tableDeck].last).to have_key(:image)
          expect(payload[:tableDeck].last).to have_key(:desc)
          expect(payload[:tableDeck].last).to have_key(:tags)
          expect(payload[:tableDeck].last).to have_key(:countAvailable)
          expect(payload[:tableDeck].last).to have_key(:id_list)
          expect(payload).to have_key(:playerOrder)
          expect(payload).to have_key(:playerInfo)
          expect(payload[:playerInfo]).to have_key(@player.name.to_sym)
          expect(payload[:playerInfo][@player.name.to_sym]).to have_key(:deckSize)
          expect(payload[:playerInfo][@player.name.to_sym]).to have_key(:topCardDiscard)
          expect(payload[:playerInfo][@player.name.to_sym]).to have_key(:handSize)
          expect(payload[:activePlayerName]).to eq(@player.name)
          expect(payload[:activePlayerId]).to eq(@player.id)
        else
          expect(message[:type]).to eq('player-joined')
        end
      }
  end
end

def create_cards
  image_url = "http://127.0.0.1:3000/card_images/"
  Card.create(name: "Copper", category: "Money", cost: 0, spending_power: 1, tags: "", desc: "", image: image_url + "Copper.jpg")
  Card.create(name: "Silver", category: "Money", cost: 3, spending_power: 2, tags: "", desc: "", image: image_url + "Silver.jpg")
  Card.create(name: "Gold", category: "Money", cost: 6, spending_power: 3, tags: "", desc: "", image: image_url + "Gold.jpg")
  Card.create(name: "Estate", category: "Victory", cost: 2, victory_points: 1, tags: "", desc: "", image: image_url + "Estate.jpg")
  Card.create(name: "Duchy", category: "Victory", cost: 5, victory_points: 3, tags: "", desc: "", image: image_url + "Duchy.jpg")
  Card.create(name: "Province", category: "Victory", cost: 8, victory_points: 6, tags: "", desc: "", image: image_url + "Province.jpg")

  Card.create(name: "Village", category: "Action", cost: 3, actions_provided: 2, cards_to_draw: 1, tags: "+1 Card,+2 Actions", desc: "", image: image_url + "Village.jpg")
  Card.create(name: "Militia", category: "Action,Attack", cost: 4, spending_power: 2, tags: "+2 Gold", desc: "Each other play discards down to 3 cards in their hand.", image: image_url + "Militia.jpg")
  Card.create(name: "Smithy", category: "Action", cost: 4, cards_to_draw: 3, tags: "+3 Cards", desc: "", image: image_url + "Smithy.jpg")
  Card.create(name: "Market", category: "Action", cost: 5, actions_provided: 1, cards_to_draw: 1, spending_power: 1, buying_power: 1, tags: "+1 Card,+1 Action,+1 Buy,+1 Gold", desc: "", image: image_url + "Market.jpg")
  Card.create(name: "Mine", category: "Action", cost: 5, tags: "", desc: "Trash a Treasure card from your hand. Gain a Treasure card costing up to 3 Treasure more; put it in your hand.", image: image_url + "Mine.jpg")
  Card.create(name: "Remodel", category: "Action", cost: 4, tags: "", desc: "Trash a card from your hand. Gain a card costing up to 2 treasure more than the trashed card.", image: image_url + "Remodel.jpg")
  Card.create(name: "Cellar", category: "Action", cost: 2, actions_provided: 1, tags: "+1 Action", desc: "Discard any number of cards. +1 Card per card discarded.", image: image_url + "Cellar.jpg")
  Card.create(name: "Moat", category: "Action,Reaction", cost: 2, cards_to_draw: 2, tags: "+2 Cards", desc: "When another player plays an Attack card, you maye reveal this from your hand. If you do, you are unaffected by that attack.", image: image_url + "Moat.jpg")
  Card.create(name: "Woodcutter", category: "Action", cost: 3, tags: "+1 Buy,+2 Gold", spending_power: 2, buying_power: 1, desc: "", image: image_url + "Woodcutter.jpg")
  Card.create(name: "Workshop", category: "Action", cost: 3, tags: "", desc: "Gain a card costing up to 4 treasure.", image: image_url + "Workshop.jpg")
end
