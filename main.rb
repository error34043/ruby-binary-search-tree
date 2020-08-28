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

  def insert(data, target_node = @root)
    new_node = Node.new(data)
    return new_node if target_node.nil?

    comparison = new_node <=> target_node
    case comparison
    when -1
      target_node.left_child = insert(data, target_node.left_child)
    when 1
      target_node.right_child = insert(data, target_node.right_child)
    else
      return new_node
    end
    target_node
  end

  def successor(target_node)
    test_node = target_node
    loop do      
      return test_node if test_node.left_child.nil?
      test_node = test_node.left_child
    end
  end

  def delete(value, target_node = @root)
    return nil if target_node.nil?

    target_node.left_child = delete(value, target_node.left_child) if value < target_node.data
    target_node.right_child = delete(value, target_node.right_child) if value > target_node.data

    if value == target_node.data
      return target_node.left_child if target_node.right_child.nil?
      return target_node.right_child if target_node.left_child.nil?

      x = successor(target_node.right_child)
      target_node = delete(x.data, target_node)
      target_node.data = x.data
    end
    target_node
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
test_tree.delete(4)
puts test_tree.pretty_print