require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'relationships' do
    it { should have_many :cards }
    it { should have_many :players }
  end

  describe 'instance methods' do
    before :each do
      @game = create(:game)
      @player1 = create(:player, game_id: @game.id)
      @player2 = create(:player, game_id: @game.id)
      @copper = create(:copper)
      @estate = create(:estate)
    end

    it 'start' do
      # Set Stable random seed for deck index generation
      srand 67890
      expect(@game.game_cards.length).to eq(0)
      expect(@player1.cards.length).to eq(0)
      expect(@player2.cards.length).to eq(0)
      @game.start

      expect(@game.cards.length).to eq(88)
      expect(@game.cards.distinct.pluck(:name)).to include(@copper.name)
      expect((@game.cards.where(name: @copper.name)).count).to eq(74)
      expect(@game.cards.distinct.pluck(:name)).to include(@estate.name)
      expect((@game.cards.where(name: @estate.name)).count).to eq(14)

      expect(@player1.cards.length).to eq(10)
      expect(@player1.cards.where('cards.name': @copper.name).count).to eq(7)
      expect(@player1.cards.where('cards.name': @estate.name).count).to eq(3)
      expect(@player2.cards.length).to eq(10)
      expect(@player2.cards.where('cards.name': @copper.name).count).to eq(7)
      expect(@player2.cards.where('cards.name': @estate.name).count).to eq(3)

      # Random Deck Order expecations
      player1_card_id_expectations = [
        @copper.id,
        @copper.id,
        @copper.id,
        @copper.id,
        @copper.id,
        @copper.id,
        @estate.id,
        @estate.id,
        @copper.id,
        @estate.id
      ]

      @player1.deck.each_with_index do |card, index|
        expect(card.card_id).to eq(player1_card_id_expectations[index])
      end

      player2_card_id_expectations = [
        @copper.id,
        @copper.id,
        @copper.id,
        @copper.id,
        @copper.id,
        @copper.id,
        @copper.id,
        @estate.id,
        @estate.id,
        @estate.id
      ]

      @player2.deck.each_with_index do |card, index|
        expect(card.card_id).to eq(player2_card_id_expectations[index])
      end
    end
  end
end
