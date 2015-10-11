require 'byebug'
require './00_tree_node.rb'

class KnightPathFinder

  def initialize
    @visited_positions = []
    @root = nil
  end

  def self.valid_moves(pos)
    new_positions = []
    all_moves = [[1, 2], [2, 1],[-1, -2],[-2, -1],[-1, 2],[2, -1],[1, -2],[-2, 1]]
    all_moves.each do |move|
      possible_move = [move[0] + pos[0], move[1] + pos[1]]
      new_positions <<  possible_move unless possible_move.any?{ |i| i > 7 || i < 0}
    end

    new_positions
  end

  def new_move_positions(pos)
    @visited_positions << pos
    positions = []
    KnightPathFinder.valid_moves(pos).each do |position|
      unless @visited_positions.include?(position)
        @visited_positions << position
        positions << position
      end
    end

    positions
  end

  def build_move_tree(start_point)
    @root = PolyTreeNode.new(start_point)
    queue = [@root]
    until queue.empty?
      parent = queue.shift
      new_move_positions(parent.value).each do |child|
        new_child = PolyTreeNode.new(child)
        new_child.parent = parent
        queue << new_child
      end
    end
  end

  def find_path(end_pos)
    square = @root.bfs(end_pos)
    trace_path_back(square)
  end

  def trace_path_back(square)
    path = [square.value]
    last_move = square
    until last_move == @root
      last_move = last_move.parent
      last_move_value = last_move.value
      path << last_move_value
    end

    path.reverse
  end

end
