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
    Node.new(array[mid], build_tree(left_arr), build_tree(right_arr))
  end

  def insert(data, target_node = @root)
    new_node = Node.new(data)
    return new_node if target_node.nil?

    case new_node <=> target_node
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

  def find(value, target_node = @root)
    return Node.new(0) if target_node.nil?

    case value <=> target_node.data
    when 0
      target_node
    when 1
      find(value, target_node.right_child)
    when -1
      find(value, target_node.left_child)
    end
  end

  def level_order(current_node = @root)
    return [] if current_node.nil?

    queue = [current_node]
    output = []
    until queue.empty?
      visiting = queue.shift
      output << visiting.data
      queue << visiting.left_child unless visiting.left_child.nil?
      queue << visiting.right_child unless visiting.right_child.nil?
    end
    output
  end

  def inorder(current_node = @root)
    return [] if current_node.nil?

    output = []
    output.push(*inorder(current_node.left_child)) unless current_node.left_child.nil?
    output << current_node.data
    output.push(*inorder(current_node.right_child)) unless current_node.right_child.nil?

    output
  end

  def preorder(current_node = @root)
    return [] if current_node.nil?

    output = []
    output << current_node.data
    output.push(*preorder(current_node.left_child)) unless current_node.left_child.nil?
    output.push(*preorder(current_node.right_child)) unless current_node.right_child.nil?

    output
  end

  def postorder(current_node = @root)
    return [] if current_node.nil?

    output = []
    output.push(*postorder(current_node.left_child)) unless current_node.left_child.nil?
    output.push(*postorder(current_node.right_child)) unless current_node.right_child.nil?
    output << current_node.data

    output
  end

  def height(target_node)
    return 0 if target_node.nil? || target_node.data.zero?

    left_tree_height = height(target_node.left_child)
    right_tree_height = height(target_node.right_child)

    left_tree_height > right_tree_height ? left_tree_height + 1 : right_tree_height + 1
  end

  def depth(target_node, search_node = @root, level = 1)
    return level if target_node == search_node
    return 0 if target_node.data.zero?

    left_depth = depth(target_node, search_node.right_child, level + 1) unless search_node.right_child.nil?
    right_depth = depth(target_node, search_node.left_child, level + 1) unless search_node.left_child.nil?

    left_depth.nil? ? right_depth : left_depth
  end

  def balanced?(tree = @root)
    return true if tree.nil?

    difference = (height(tree.right_child) - height(tree.left_child)).abs
    return true if difference <= 1 && balanced?(tree.left_child) && balanced?(tree.right_child)

    false
  end

  def rebalance(_ = @root)
    @root = build_tree(level_order) unless balanced?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
