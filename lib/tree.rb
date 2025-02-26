# frozen_string_literal: true

require "./lib/node.rb"

class Tree 
  def initialize(unfiltered_array)
    @root = build_tree(unfiltered_array.uniq.sort)
  end
end