# frozen_string_literal: true

require './lib/node'

# Holds root node of tree and abilities to manipulate and traverse tree
class Tree 
  def initialize(unfiltered_array)
    @array = unfiltered_array.uniq.sort
    @root = build_tree(@array, 0, @array.length - 1)
  end

  def insert(data)
    traverse_tree(data) do |node, move|
      if move.negative?
        node.left = Node.new(data)
      elsif move.positive?
        node.right = Node.new(data)
      elsif move.zero?
        puts 'move equals zero should not happen in insert and did'
      end
    end
  end

  def delete(data)
    return delete_root if data == @root.data
    return nil unless parent = find_parent(data)

    move = data <=> parent.data
    node = move.negative? ? parent.left : parent.right
    case node.count_children
    when 0
      parent.assign_child(nil, move)
    when 1
      parent.assign_child(node.left || node.right)
    when 2
      replace(node)
    end
  end

  def level_order(&block)
    if block_given?
      @root.queue([@root], &block)
    else
      full_list = []
      @root.queue([@root]) { |curr| full_list << curr.data }
      full_list
    end
  end

  def inorder(&block)
    ordered_tree = @root.order_fam(&:fam_to_array_inorder)
    if block_given?
      ordered_tree.each(&block)
    else
      ordered_tree.map(&:data)
    end
  end

  def preorder(&block)
    ordered_tree = @root.order_fam(&:fam_to_array_preorder)
    if block_given?
      ordered_tree.each(&block)
    else
      ordered_tree.map(&:data)
    end
  end

  def postorder(&block)
    ordered_tree = @root.order_fam(&:fam_to_array_postorder)
    if block_given?
      ordered_tree.each(&block)
    else
      ordered_tree.map(&:data)
    end
  end

  def find(data)
    @root.traverse_nodes(data)
  end

  def height(node)
    if node.leaf?
      0
    elsif node.count_children == 1
      node.left ? height(node.left) + 1 : height(node.right) + 1
    elsif height(node.left) > height(node.right)
      height(node.left) + 1
    else
      height(node.right) + 1
    end
  end

  def depth(node)
    @root.count_edges_to(node)
  end

  def level_order_i
    queue = [@root]
    full = []
    until queue.empty?
      curr = queue.shift
      curr.add_children_to(queue)
      if block_given?
        yield(curr)
      else
        full << curr.data
      end
    end
    full unless block_given?
  end

  def build_tree(array, start, stop)
    return nil if start > stop

    middle = start + ((stop - start)/2).floor
    root = Node.new(array[middle])
    root.left = build_tree(array, start, middle - 1)
    root.right = build_tree(array, middle + 1, stop)
    root
  end

  def balanced?
    balanced = true
    level_order do |node|
      left_height = node.left ? height(node.left) + 1 : 0
      right_height = node.right ? height(node.right) + 1 : 0
      balanced = false unless [-1, 0, 1].include?(left_height - right_height)
    end
    balanced
  end

  def rebalance
    array = inorder
    @root = build_tree(array, 0, array.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # Move through Nodes of a tree to reach data, if data doesn't
  #   exist in tree yield to block with access to child attribute
  #   where data would be.
  def traverse_tree(data, &block)
    # child_attribute is either @left or @right of the last node reached before nil
    @root.traverse_nodes(data, &block)
  end

  def find_parent(data)
    @root.traverse_parent_nodes(data)
  end

  private

  def replace(node)
    replacement = node.next_biggest
    new_data = replacement.data
    delete(new_data)
    node.data = new_data
  end

  def delete_root
    case @root.count_children
    when 0
      @root = nil
    when 1
      @root = @root.left || @root.right
    when 2
      replace(@root)
    end
  end
end
