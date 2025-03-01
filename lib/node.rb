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
end