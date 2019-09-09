require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'relationships' do
    it { should belong_to :game }
  end

  describe 'instance methods' do
    before :each do
      @game = create(:game)
      @player = create(:player, game_id: @game.id)
      @gold = create(:gold)
      @estate = create(:estate)
      create_list(:game_card, 30, game_id: @game.id, card_id: @gold.id)
      create_list(:game_card, 8, game_id: @game.id, card_id: @estate.id)
    end

    it '#cards' do
      expect(@player.cards).to eq([])
    end

    it '#buy' do
      expect(@player.cards.length).to eq(0)
      @player.buy(@gold.name)
      expect(@player.cards.length).to eq(1)
      expect(@player.cards.first.card.name).to eq(@gold.name)
      expect(@game.game_cards.joins(:card).where('cards.name': @gold.name, player_id: nil).length).to eq(29)
    end

    it '#deck' do
      deck_indexes = [1, 3, 7, 4, 5, 2, 6]
      GameCard.joins(:card)
      .where(game_id: @game.id, 'cards.name': @gold.name)
      .limit(5)
      .each do |card|
        card.update(player_id: @player.id, deck_index: deck_indexes.pop)
      end
      GameCard.joins(:card)
      .where(game_id: @game.id, 'cards.name': @estate.name)
      .limit(2)
      .each do |card|
        card.update(player_id: @player.id, deck_index: deck_indexes.pop)
      end
      expect(@player.deck.length).to eq(7)
      @player.deck.each_with_index do |card, index|
        expect(card.deck_index).to eq(index + 1)
      end
    end

    it '#discard' do
      GameCard.joins(:card).where(game_id: @game.id, 'cards.name': @gold.name).limit(5).update(player_id: @player.id)
      GameCard.joins(:card).where(game_id: @game.id, 'cards.name': @estate.name).limit(2).update(player_id: @player.id)
      GameCard.joins(:card).where(game_id: @game.id, 'cards.name': @gold.name).limit(3).update(discarded: true, player_id: @player.id)
      GameCard.joins(:card).where(game_id: @game.id, 'cards.name': @estate.name).limit(1).update(discarded: true, player_id: @player.id)
      expect(@player.discard.length).to eq(4)
    end
  end
end
