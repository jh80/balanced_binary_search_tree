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
    return self if @data == data
    if data < @data
      return nil if @left.nil?
      return @left.traverse_nodes(data)
    end
    if data > @data 
      return nil if @right.nil? 
      return @right.traverse_nodes(data)
    end
  end
end