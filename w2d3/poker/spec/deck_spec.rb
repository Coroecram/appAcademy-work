require 'deck'

describe Deck do
  let(:sample_deck) { Deck.new }

  describe "#initialize" do
    it "has 52 cards" do
      expect(sample_deck.cards.count).to eq(52)
    end

    it "13 cards of each suit" do
      expect(sample_deck.cards.count { |card| card.suit == :hearts }).to eq(13)
      expect(sample_deck.cards.count { |card| card.suit == :diamonds }).to eq(13)
      expect(sample_deck.cards.count { |card| card.suit == :spades }).to eq(13)
      expect(sample_deck.cards.count { |card| card.suit == :clubs }).to eq(13)
    end

    it "4 cards of each type" do
      Deck::CARD_FACES.each do |val|
        expect(sample_deck.cards.select{|card| card.face == val}.count).to eq(4)
      end
    end
  end

  describe "#shuffle_cards" do
    it "can shuffle cards" do
      expect{sample_deck.shuffle_cards}.to change{sample_deck.cards}
    end
  end
end
