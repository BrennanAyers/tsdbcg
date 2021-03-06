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
      @silver = create(:silver)
      @gold = create(:gold)
      @estate = create(:estate)
      @duchy = create(:duchy)
      @province = create(:province)
      @village = create(:village)
      @militia = create(:militia)
      @smithy = create(:smithy)
      @market = create(:market)
      @mine = create(:mine)
      @remodel = create(:remodel)
      @cellar = create(:cellar)
      @moat = create(:moat)
      @woodcutter = create(:woodcutter)
      @workshop = create(:workshop)
    end

    it 'start' do
      # Set Stable random seed for deck index generation
      srand 67890
      expect(@game.game_cards.length).to eq(0)
      expect(@player1.cards.length).to eq(0)
      expect(@player2.cards.length).to eq(0)
      @game.start
      expect(@game.cards.length).to eq(274)
      expect(@game.cards.distinct.pluck(:name)).to include(@copper.name)
      expect((@game.cards.where(name: @copper.name)).count).to eq(74)
      expect(@game.cards.distinct.pluck(:name)).to include(@silver.name)
      expect((@game.cards.where(name: @silver.name)).count).to eq(40)
      expect(@game.cards.distinct.pluck(:name)).to include(@gold.name)
      expect((@game.cards.where(name: @gold.name)).count).to eq(30)
      expect(@game.cards.distinct.pluck(:name)).to include(@estate.name)
      expect((@game.cards.where(name: @estate.name)).count).to eq(14)
      expect(@game.cards.distinct.pluck(:name)).to include(@duchy.name)
      expect((@game.cards.where(name: @duchy.name)).count).to eq(8)
      expect(@game.cards.distinct.pluck(:name)).to include(@province.name)
      expect((@game.cards.where(name: @province.name)).count).to eq(8)
      expect(@game.cards.distinct.pluck(:name)).to include(@village.name)
      expect((@game.cards.where(name: @village.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@militia.name)
      expect((@game.cards.where(name: @militia.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@smithy.name)
      expect((@game.cards.where(name: @smithy.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@market.name)
      expect((@game.cards.where(name: @market.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@mine.name)
      expect((@game.cards.where(name: @mine.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@remodel.name)
      expect((@game.cards.where(name: @remodel.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@cellar.name)
      expect((@game.cards.where(name: @cellar.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@moat.name)
      expect((@game.cards.where(name: @moat.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@woodcutter.name)
      expect((@game.cards.where(name: @woodcutter.name)).count).to eq(10)
      expect(@game.cards.distinct.pluck(:name)).to include(@workshop.name)
      expect((@game.cards.where(name: @workshop.name)).count).to eq(10)

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
