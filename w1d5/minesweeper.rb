#Minesweeper

require 'byebug'

class Tile

  attr_accessor :flagged, :revealed, :display
  attr_reader :mined, :index

  def initialize(index, mined = nil)
    @mined = mined
    @flagged = false
    @revealed = false
    @display = "*"
    @index = index
  end

  def reveal
    self.revealed = true
  end


end

class Board

NEIGHBOR = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]]

  attr_reader :grid

  def initialize(size = 9)
    @grid = Array.new(size) { Array.new(size) }
    @grid = populate(@grid)
  end

  def populate(grid)
    # byebug
    grid.each_with_index do |array, y|
      array.each_with_index do |member, x|
        checknum = 5
        checkbomb = rand(30)
        place_mine = checkbomb < checknum ? true : false
        array[x] = Tile.new([x, y], place_mine)
      end
    end
  end

  def update(tile)
    if tile.mined
      tile.revealed = true
      tile.display = "!"
    else
      neighbor_tiles = neighbors(tile.index)
      tile.display = neighbor_bomb_count(neighbor_tiles)
      tile.revealed = true
      neighbor_tiles.each do |tile|
        if tile.mined == true || tile.revealed == true
          neighbor_tiles.delete(tile)
        end
      end


    end

  end

  def neighbors(pos)
    neighbors = []
    NEIGHBOR.each do |i|
      new_pos = [pos[0] + i[0], pos[1] + i[1]]
      if new_pos.all? { |coord| coord.between?(0,8)}
        neighbors << new_pos
      end
    end
    neighbor_tiles = []

    grid.each do |row|
      row.each do |tile|
        # byebug
        neighbor_tiles << tile if neighbors.include?(tile.index)
      end
    end

    neighbor_tiles
  end

  def neighbor_bomb_count(neighbors)
    count = 0
    neighbors.each do |neighbor|
      count += 1 if neighbor.mined == true
    end

    count
  end

  def render
    puts " ____________________________________"
    # byebug
    grid.each do |row|
      print "|"
      row.each do |tile|
        print " #{tile.display} |"
      end
      puts
    end
    puts "_____________________________________"
  end


end

class Game

  attr_reader :player, :squares
  attr_accessor :board

  def initialize(player)
    @player = player
    @board = Board.new
    @squares = board.grid
  end

  def run
    until won? || lost?
      take_turn
      puts "#{player}, you won!" if won?
      puts "#{player}, you lost." if lost?
    end
  end

  # def game_over?
  #   return true if won? || lost?
  # end

  def won?
    squares.each do |array|
      array.each do |member|
        return false if member.revealed == false && member.mined == false
      end
    end
    true
  end

  def lost?
    squares.each do |array|
      array.each do |member|
        return true if member.revealed == true && member.mined == true
      end
    end
    false
  end

  def take_turn

    puts "Type r to reveal or f to flag."
    command = gets.chomp

    puts "Type the square coordinate 'x, y'"
    coord_string = gets.chomp
    coord_array = coord_string.split(", ")
    row = coord_array[1].to_i
    col = coord_array[0].to_i
    tile = board.grid[row][col]

    if command == "r"
      tile.revealed = true
      tile.display = "_"
      board.update(tile)
    elsif command == "f"
      if tile.flagged == false
        tile.flagged = true
        tile.display = "F"
      else
        tile.flagged = false
        tile.display = "*"
      end
    end

    board.render
  end




end
