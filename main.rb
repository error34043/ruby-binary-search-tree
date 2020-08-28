# frozen-string-literal: true

# Represents a single node
class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def <=>(other)
    @data <=> other.data
  end

  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end

# Represents an entire tree
class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array = array.uniq.sort
    return nil if array.empty?

    mid = (array.length - 1) / 2
    left_arr = array.slice(0, mid)
    right_arr = array.slice(mid + 1, array.length - 1)
    root = Node.new(array[mid], build_tree(left_arr), build_tree(right_arr))
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end


### TESTING
# test = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test = [7, 6, 5, 4, 3, 2, 1]
test_tree = Tree.new(test)
puts test_tree.pretty_print