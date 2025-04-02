# frozen_string_literal: true

# Helps node class functions
module Nodeable
  # Helper for traverse_nodes
  def next_node(move, data, &block)
    child_attr = move.negative? ? @left : @right
    return yield(self, move) if child_attr.nil?

    child_attr.traverse_nodes(data, &block)
  end

  # Helpers for step_toward
  def get_move(decendant)
    if decendant.instance_of?(Node)
      decendant.data <=> data
    else
      decendant <=> data
    end
  end

  def get_child(move)
    if move.zero?
      puts 'GET CHILD WAS USED ON A ZERO MOVE'
    else
      move.negative? ? left : right
    end
  end

  def step_toward(decendant)
    move = get_move(decendant)
    return 0 if move.zero?

    get_child(move)
  end
end
