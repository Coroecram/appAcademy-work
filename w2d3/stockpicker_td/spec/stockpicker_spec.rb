require "stockpicker"

describe "#stockpicker" do
  let(:prices) { [5, 4, 2, 3, 8] }

  let(:bad_prices) { [5, 4, 3, 2, 1] }

  it "returns [] for an empty array" do
    expect(stockpicker([])).to eq([])
  end

  it "returns [] for an array of length 1" do
    expect(stockpicker([1])).to eq([])
  end

  it "outputs the most profitable pair of days" do
    expect(stockpicker(prices)).to eq([2,4])
  end

  it "returns 0 if no profitable pair of days" do
    expect(stockpicker(bad_prices)).to eq([])
  end
  
  it "does not modify the original" do
    expect{ stockpicker(prices) }.to_not change{ prices }
  end

end
