# balanced_binary_search_tree

This project can be used to build an manipulate a 
binary search tree that is balanced upon initiation.

Features
#new
    Initiate an instance of tree using an array. 
    The array does not have to be ordered.

#insert
    Insert a node into an existing tree using a
    data value.

#delete

#level_order

#inorder

#preorder

#postorder

#find

#height

#depth

#level_order_i
    Traverse the tree in level order interativley.

#balanced

#rebalance

#pretty_print

Possible issues
    Does delete delete the nodes enough to release the memory?
    Deleteing a node that had 2 children puts new information into
    the node instead of deleting it. Would that cause issues?
    Is there a reasonable scenario where someone would save a node
    to a variable and then use is again and expect it not to have
    changed? It was going to be deleted, so node name is being recycled