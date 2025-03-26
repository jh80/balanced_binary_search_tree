# frozen_string_literal: true

require './lib/nodeable'
require './lib/orderable'
# Stores data and used with other nodes to build a binary search tree
class Node
  include Comparable
  include Nodeable
  include Orderable
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
    return self if move.zero?

    next_node(move, data) {|node, move| yield(node, move)}
  end

  def traverse_parent_nodes(data)
    child = (data <=> self.data).negative? ? left : right
    return nil if child.nil?
    return self if child.data == data

    child.traverse_parent_nodes(data)
  end

  def leaf?
    return true if left.nil? && right.nil?

    false
  end

  def count_children
    return 0 if leaf?
    return 2 if left && right

    1
  end

  def assign_child(new_child, move = nil)
    move ||= new_child.data <=> data
    if move.negative?
      self.left = new_child
    elsif move.positive?
      self.right = new_child
    end
  end

  def add_children_to(array)
    array << left unless left.nil?
    array << right unless right.nil?
  end

  def next_biggest
    # find smallest in path from bigger child
    right.smallest_in_path
  end

  def smallest_in_path
    if left
      left.smallest_in_path
    else
      self
    end
  end

  def queue(array)
    return if array.empty?

    curr = array[0]
    curr.add_children_to(array)
    yield(curr)
    array.shift
    array[0].queue(array) {|curr| yield(curr)} unless array.empty?
  end

  def count_edges_to(node)
    child = step_toward(node)
    return nil if node.nil?
    return nil if child.nil?
    # child will == 0 when step_toward argument is the same node that called step_toward
    return 0 if child.zero?

    count = child.count_edges_to(node)
    return  count + 1 if child && count

    # Return nil if child doesn't exist
    nil
  end
end
