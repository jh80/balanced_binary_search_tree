# frozen_string_literal: true

class Node 
  include Comparable
  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end