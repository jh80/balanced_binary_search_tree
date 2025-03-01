# frozen_string_literal: true

require "./lib/node.rb"

class Tree 
  def initialize(unfiltered_array)
    @array = unfiltered_array.uniq.sort
    @root = build_tree(@array, 0, @array.length - 1)
  end

  def insert(data)
    traverse_tree(data) do |node, move| 
      if move < 0
        node.left = Node.new(data)
      elsif move > 0
        node.right = Node.new(data)
      else move == 0
        puts "move equals zero should not happen in insert and did"
      end
    end
  end

  def build_tree(array, start, stop)
    return nil if start > stop
      
    middle = start + ((stop - start)/2).floor
    root = Node.new(array[middle])
    root.left = build_tree(array, start, middle - 1)
    root.right = build_tree(array, middle + 1, stop)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # Move through Nodes of a tree to reach data, if data doesn't 
  #   exist in tree yield to block with access to child attribute
  #   where data would be.
  def traverse_tree(data)
    # child_attribute is either @left or @right of the last node reached before nil
    @root.traverse_nodes(data) { |node, move| yield(node, move) }
  end
end