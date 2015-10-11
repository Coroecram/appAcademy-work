require 'card'

describe Card do
  let(:sample_card) { Card.new(2, :hearts) }
  let(:sample_queen) { Card.new("Q", :spades) }

  describe "#initialize" do

    it "has a face" do
      expect(sample_card.face).to eq(2)
    end

    it "has a suit of hearts" do
      expect(sample_card.suit).to eq(:hearts)
    end

  end

  describe "#value" do

    it "returns the value of a number card" do
      expect(sample_card.value).to eq(2)
    end

    it "returns the value of a face card" do
      expect(sample_queen.value).to eq(12)
    end

  end

  describe "#color" do

    it "returns 'red' for hearts or diamonds" do
      expect(sample_card.color).to eq(:red)
    end

    it "returns 'black' for spades or clubs" do
      expect(sample_queen.color).to eq(:black)
    end

  end


end
