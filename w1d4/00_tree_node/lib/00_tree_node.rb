require 'byebug'

class PolyTreeNode

  attr_reader :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def value
    @value
  end

  def parent=(new_parent)
    return if self.parent == new_parent

    self.parent.children.delete(self) unless @parent.nil?
    @parent = new_parent
    new_parent.children << self unless new_parent.nil?
  end

  def add_child(child_node)
     child_node.parent = self unless child_node.nil?
  end

  def remove_child(child)
    raise "not the parent's child" unless self.children.include?(child)

    self.children.delete(child)
    child.parent = nil
  end

  def dfs(target_value)
     return self if target_value == self.value

     self.children.each do |child|
       prev = child.dfs(target_value)
       return prev unless prev.nil?
     end

    nil
  end

  def bfs(target_value)
    stack = [self]
    until stack.empty?
      node = stack.shift
      return node if node.value == target_value
      stack += node.children
    end

    nil
  end
end

# Test code
# nodes = ('a'..'g').map { |value| PolyTreeNode.new(value) }
#
# parent_index = 0
# nodes.each_with_index do |child, index|
#   next if index.zero?
#   child.parent = nodes[parent_index]
#   parent_index += 1 if index.even?
# end
#  p nodes.first.bfs("e")
