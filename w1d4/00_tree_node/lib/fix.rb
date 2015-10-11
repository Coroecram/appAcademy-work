
nodes = ('a'..'g').map { |value| PolyTreeNode.new(value) }

parent_index = 0
nodes.each_with_index do |child, index|
  next if index.zero?
  child.parent = nodes[parent_index]
  parent_index += 1 if index.even?
end
