# frozen_string_literal: true

# Orders elements for ordering tree
module Orderable
  def order_fam(&block)
    fam = yield(self)
    if fam.length == 1
      fam
    else
      fam.reduce([]) do |ordered_fams, node|
        if node == self
          ordered_fams + [node]
        else
          ordered_fams + node.order_fam(&block)
        end
      end
    end
  end

  def fam_to_array_inorder
    fam = []
    fam << left unless left.nil?
    fam << self
    fam << right unless right.nil?
    fam
  end

  def fam_to_array_preorder
    fam = []
    fam << self
    fam << left unless left.nil?
    fam << right unless right.nil?
    fam
  end

  def fam_to_array_postorder
    fam = []
    fam << left unless left.nil?
    fam << right unless right.nil?
    fam << self
    fam
  end
end
