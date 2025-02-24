# frozen_string_literal: true

class Node 
  include Comparable

  attr_accessor :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end