require 'array_exercises'

describe Array do


  describe "#my_uniq" do
    let(:arr) { [1,1,2,2] }

    it "returns an empty array if given an empty array" do
      expect([].my_uniq).to eq([])
    end

    it "returns single element array" do
      expect([1].my_uniq).to eq([1])
    end

    it "#my_uniq returns an array of uniq values" do
      expect(arr.my_uniq).to eq([1,2])
    end

    it "does not modify original" do
      expect{arr.my_uniq}.to_not change{arr}
    end
  end

  describe "#two_sum" do
    let(:arr) { [-1, 0, 2, -2, 1] }

    it "returns an empty array if given an empty array" do
      expect([].two_sum).to eq([])
    end

    it "returns single element array" do
      expect([1].two_sum).to eq([])
    end

    it "finds all pairs of positions where the elements at those positions sum to zero" do
      expect(arr.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "does not modify original" do
      expect{arr.two_sum}.to_not change{arr}
    end
  end

  describe "#transpose" do
    let(:arr) { [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
      ] }

    let(:rect_arr) { [
      [1, 2, 3],
      [4, 5, 6]
      ] }

    it "returns an empty array if given an empty array" do
      expect([].my_transpose).to eq([])
    end

    it "returns single element array" do
      expect([1].my_transpose).to eq([1])
    end

    it "transposes a square matrix" do
      expect(arr.my_transpose).to eq([[1, 4, 7],
                                      [2, 5, 8],
                                      [3, 6, 9]])
    end

    it "transposes a rectangular matrix" do
      expect(rect_arr.my_transpose).to eq([[1, 4],
                                           [2, 5],
                                           [3, 6]])
    end

    it "does not modify original" do
      expect{arr.my_transpose}.to_not change{arr}
    end
  end

end
