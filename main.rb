require 'pry-byebug'

require "./lib/node.rb"
require "./lib/tree.rb"

def check_balance(tree)
  puts "It is #{tree.balanced?} that the tree is balanced"
end

rand_array = (Array.new(15) { rand(1..100)})
bst = Tree.new(rand_array)

bst.pretty_print
check_balance(bst)
display = lambda do |node|
  print "#{node}: "
  print node.data
  puts
end

puts "Level Order"
bst.level_order { |node| display.call(node) }
puts "Pre Order"
bst.preorder { |node| display.call(node)}
puts "Post Order"
bst.postorder { |node| display.call(node)}
puts "In Order"
bst.inorder { |node| display.call(node) }

(1...4).each {bst.insert(rand(101..200))}

bst.pretty_print
check_balance(bst)
bst.rebalance
check_balance(bst)

puts "Level Order"
bst.level_order { |node| display.call(node) }
puts "Pre Order"
bst.preorder { |node| display.call(node) }
puts "Post Order"
bst.postorder { |node| display.call(node) }
puts "In Order"
bst.inorder { |node| display.call(node) }

