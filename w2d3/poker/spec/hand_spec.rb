require 'hand'
require 'card'

describe Hand do
  cards = []
  let(:sample_hand) { Hand.new }

  let(:high_card) { [Card.new(2, :hearts),
                        Card.new(3, :spades),
                        Card.new(7, :clubs),
                        Card.new(9, :hearts),
                        Card.new("Q", :hearts)] }

  let(:pair) { [Card.new(2, :hearts),
                        Card.new(2, :spades),
                        Card.new(7, :hearts),
                        Card.new(3, :hearts),
                        Card.new(5, :hearts)] }

  let(:two_pair) { [Card.new(2, :hearts),
                        Card.new(2, :spades),
                        Card.new(7, :hearts),
                        Card.new(7, :hearts),
                        Card.new(5, :hearts)] }

  let(:three_kind) { [Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(3, :spades),
                        Card.new(5, :hearts)] }

  let(:four_kind) { [Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(5, :spades)] }

  let(:four_flush) { [Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(2, :hearts),
                        Card.new(5, :hearts)] }

  let(:straight)   { [Card.new(2, :hearts),
                        Card.new(3, :hearts),
                        Card.new(4, :diamonds),
                        Card.new(5, :hearts),
                        Card.new(6, :hearts)] }

  let(:ace_high_straight) { [Card.new(10, :hearts),
                        Card.new("J", :hearts),
                        Card.new("Q", :diamonds),
                        Card.new("K", :hearts),
                        Card.new("A", :hearts)] }

  let(:ace_low_straight) { [Card.new("A", :hearts),
                        Card.new(2, :hearts),
                        Card.new(3, :diamonds),
                        Card.new(4, :hearts),
                        Card.new(5, :hearts)] }

  let(:straight_flush) { [Card.new(2, :hearts),
                        Card.new(3, :hearts),
                        Card.new(4, :hearts),
                        Card.new(5, :hearts),
                        Card.new(6, :hearts)] }

  let(:royal_flush) { [Card.new(10, :hearts),
                        Card.new("J", :hearts),
                        Card.new("Q", :hearts),
                        Card.new("K", :hearts),
                        Card.new("A", :hearts)] }

  describe "#initialize" do

    it "initializes a cards variable" do
      expect(sample_hand.cards.is_a?(Array)).to be true
    end

  end

  describe "#push" do
    it "doesn't allow more than 5 cards" do
      sample_hand.cards = high_card
      expect{sample_hand.push(Card.new(10, :spades))}.to_not change{sample_hand.cards}
    end
  end

  describe "#check_hand" do
    it "returns high card" do
      sample_hand.cards = high_card
      expect(sample_hand.check_hand).to eq(sample_hand.cards.last)
    end

    it "returns a pair" do
      sample_hand.cards = pair
      expect(sample_hand.check_hand).to eq(sample_hand.cards[0..1])
    end
  end

# describe "#pair?" do
#
#   it "detects a pair"
#
end

# sample_hand.cards = sample_cards
# p sample_hand.cards
