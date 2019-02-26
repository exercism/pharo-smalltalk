"
# Binary Search Tree

Insert and search for numbers in a binary tree.

When we need to represent sorted data, an array does not make a good
data structure.

Say we have the array `[1, 3, 4, 5]`, and we add 2 to it so it becomes
`[1, 3, 4, 5, 2]` now we must sort the entire array again! We can
improve on this by realizing that we only need to make space for the new
item `[1, nil, 3, 4, 5]`, and then adding the item in the space we
added. But this still requires us to shift many elements down by one.

Binary Search Trees, however, can operate on sorted data much more
efficiently.

A binary search tree consists of a series of connected nodes. Each node
contains a piece of data (e.g. the number 3), a variable named `left`,
and a variable named `right`. The `left` and `right` variables point at
`nil`, or other nodes. Since these other nodes in turn have other nodes
beneath them, we say that the left and right variables are pointing at
subtrees. All data in the left subtree is less than or equal to the
current node's data, and all data in the right subtree is greater than
the current node's data.

For example, if we had a node containing the data 4, and we added the
data 2, our tree would look like this:

      4
     /
    2

If we then added 6, it would look like this:

      4
     / \
    2   6

If we then added 3, it would look like this

       4
     /   \
    2     6
     \
      3

And if we then added 1, 5, and 7, it would look like this

          4
        /   \
       /     \
      2       6
     / \     / \
    1   3   5   7

## Hint

TBD

"
Class {
	#name : #BinarySearchTreeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'binarySearchTreeCalculator'
	],
	#category : #'ExercismWIP-BinarySearchTree'
}

{ #category : #config }
BinarySearchTreeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'4ff6e3d9-2b3f-0d00-a2bd-c7b509f0590c'
]

{ #category : #config }
BinarySearchTreeTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
BinarySearchTreeTest >> setUp [
	binarySearchTreeCalculator := BinarySearchTree new
]

{ #category : #test }
BinarySearchTreeTest >> testCanCreateComplexTree [
	| result |

	result := binarySearchTreeCalculator dataTreeData: #('4' '2' '6' '1' '3' '5' '7' ) .
	self assert: result equals: ((Dictionary new) add: ('data'->'4'); add: ('right'->((Dictionary new) add: ('data'->'6'); add: ('right'->((Dictionary new) add: ('data'->'7'); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('data'->'5'); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)); add: ('left'->((Dictionary new) add: ('data'->'2'); add: ('right'->((Dictionary new) add: ('data'->'3'); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('data'->'1'); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)); yourself)
]

{ #category : #test }
BinarySearchTreeTest >> testCanSortDataCanSortComplexTree [
	| result |

	result := binarySearchTreeCalculator sortedDataTreeData: #('2' '1' '3' '6' '7' '5' ) .
	self assert: result equals: #('1' '2' '3' '5' '6' '7' )
]

{ #category : #test }
BinarySearchTreeTest >> testCanSortDataCanSortIfSecondNumberIsGreaterThanFirst [
	| result |

	result := binarySearchTreeCalculator sortedDataTreeData: #('2' '3' ) .
	self assert: result equals: #('2' '3' )
]

{ #category : #test }
BinarySearchTreeTest >> testCanSortDataCanSortIfSecondNumberIsSameAsFirst [
	| result |

	result := binarySearchTreeCalculator sortedDataTreeData: #('2' '2' ) .
	self assert: result equals: #('2' '2' )
]

{ #category : #test }
BinarySearchTreeTest >> testCanSortDataCanSortIfSecondNumberIsSmallerThanFirst [
	| result |

	result := binarySearchTreeCalculator sortedDataTreeData: #('2' '1' ) .
	self assert: result equals: #('1' '2' )
]

{ #category : #test }
BinarySearchTreeTest >> testCanSortDataCanSortSingleNumber [
	| result |

	result := binarySearchTreeCalculator sortedDataTreeData: #('2' ) .
	self assert: result equals: #('2' )
]

{ #category : #test }
BinarySearchTreeTest >> testDataIsRetained [
	| result |

	result := binarySearchTreeCalculator dataTreeData: #('4' ) .
	self assert: result equals: ((Dictionary new) add: ('data'->'4'); add: ('right'->nil); add: ('left'->nil); yourself)
]

{ #category : #test }
BinarySearchTreeTest >> testInsertDataAtProperNodeGreaterNumberAtRightNode [
	| result |

	result := binarySearchTreeCalculator dataTreeData: #('4' '5' ) .
	self assert: result equals: ((Dictionary new) add: ('data'->'4'); add: ('right'->((Dictionary new) add: ('data'->'5'); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)
]

{ #category : #test }
BinarySearchTreeTest >> testInsertDataAtProperNodeSameNumberAtLeftNode [
	| result |

	result := binarySearchTreeCalculator dataTreeData: #('4' '4' ) .
	self assert: result equals: ((Dictionary new) add: ('data'->'4'); add: ('right'->nil); add: ('left'->((Dictionary new) add: ('data'->'4'); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)
]

{ #category : #test }
BinarySearchTreeTest >> testInsertDataAtProperNodeSmallerNumberAtLeftNode [
	| result |

	result := binarySearchTreeCalculator dataTreeData: #('4' '2' ) .
	self assert: result equals: ((Dictionary new) add: ('data'->'4'); add: ('right'->nil); add: ('left'->((Dictionary new) add: ('data'->'2'); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)
]
