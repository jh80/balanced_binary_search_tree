# frozen_string_literal: true

class Node 
  include Comparable

  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def pretty_print(node = self, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def traverse_nodes(data)
    move = data <=> @data
    return self if move == 0

    next_node(move, data) {|node, move| yield(node, move)}
  end

  def next_node(move, data)
    child_attr = move < 0 ? @left : @right
    return yield(self, move) if child_attr.nil?
    return child_attr.traverse_nodes(data) {|node, move| yield(node, move)}
  end 

  def traverse_parent_nodes(data)
    child = ((data <=> self.data) < 0) ? self.left : self.right
    return nil if child == nil
    return self if child.data == data
    return child.traverse_parent_nodes(data)
  end    

  def leaf?
    return true if self.left.nil? && self.right.nil?
    false
  end

  def count_children
    return 0 if self.leaf?
    return 2 if self.left && self.right
    return 1 
  end

  def assign_child(new_child, move = nil)
    move = new_child.data <=> self.data unless move
    if move < 0
      self.left = new_child
    elsif move > 0
      self.right = new_child
    end
  end

  def next_biggest
    # find smallest in path from bigger child
    self.right.smallest_in_path
  end

  def smallest_in_path
    if self.left
      return self.left.smallest_in_path
    else
      return self
    end
  end
end