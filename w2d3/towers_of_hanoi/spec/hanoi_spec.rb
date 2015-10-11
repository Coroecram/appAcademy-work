require "hanoi"

describe Game do
  let(:game) { Game.new }

  context "New Game" do
    it "initializes with 3 towers" do
      expect(game.towers.count).to eq(3)
    end

    it "initializes with 3 disks in order in the first column" do
      expect(game.towers.first).to eq([1,2,3])
    end

    it "initializes 2 empty columns after the first" do
      expect(game.towers[1] && game.towers[2]).to eq([nil, nil, nil])
    end

    it "renders the columns in the console" do
      expect(game.render).to eq(" |1|  | |  | | \n |2|  | |  | | \n |3|  | |  | | \n  A    B    C  \n")
    end

    # it "starts game#play" do
    #   expect(game2).to receive{:play}
    #   let(:game2) { Game.new }
    # end
  end


  describe "#move" do
    it "moves to another tower" do
      expect(game.move(0, 1)).to eq([[nil, 2, 3], [nil, nil, 1], [nil, nil, nil]])
    end

    it "doesn't move to another tower with a smaller disc" do
      game_invalid_move = Game.new
      game_invalid_move.towers[0] = [nil, 2, 3]
      game_invalid_move.towers[1] = [nil, nil, 1]
      expect{game_invalid_move.move(0,1)}.to_not change{game_invalid_move.towers}
    end
  end

  it "finishes when a tower is made in last column" do
    game_won = Game.new
    game_won.towers[2] = [1,2,3]

    expect(game_won.won?).to be true
  end
end
