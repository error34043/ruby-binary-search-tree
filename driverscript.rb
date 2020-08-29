# frozen-string-literal: true

require_relative 'main.rb'

tree_array = Array.new(15) { rand(1..100) }
tree = Tree.new(tree_array)
puts tree.pretty_print
balance_state = tree.balanced?
puts "Is the tree balanced? #{balance_state}"
levelo = tree.level_order
preo = tree.preorder
posto = tree.postorder
ino = tree.inorder
puts "Elements in level order: #{levelo}"
puts "Elements in preorder: #{preo}"
puts "Elements in postorder: #{posto}"
puts "Elements in inorder: #{ino}"
random_elements = Array.new(20) { rand(100..500) }
random_elements.each do |element|
  tree.insert(element)
end
puts ''
puts tree.pretty_print
balance_state = tree.balanced?
puts "Is the tree still balanced? #{balance_state}"
puts ''
tree.rebalance
puts tree.pretty_print
balance_state = tree.balanced?
puts "Is the tree balanced after rebalancing? #{balance_state}"
levelo = tree.level_order
preo = tree.preorder
posto = tree.postorder
ino = tree.inorder
puts "Elements in level order: #{levelo}"
puts "Elements in preorder: #{preo}"
puts "Elements in postorder: #{posto}"
puts "Elements in inorder: #{ino}"
