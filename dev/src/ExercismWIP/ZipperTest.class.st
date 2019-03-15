"
# Zipper

Creating a zipper for a binary tree.

[Zippers](https://en.wikipedia.org/wiki/Zipper_%28data_structure%29) are
a purely functional way of navigating within a data structure and
manipulating it.  They essentially contain a data structure and a
pointer into that data structure (called the focus).

For example given a rose tree (where each node contains a value and a
list of child nodes) a zipper might support these operations:

- `from_tree` (get a zipper out of a rose tree, the focus is on the root node)
- `to_tree` (get the rose tree out of the zipper)
- `value` (get the value of the focus node)
- `prev` (move the focus to the previous child of the same parent,
  returns a new zipper)
- `next` (move the focus to the next child of the same parent, returns a
  new zipper)
- `up` (move the focus to the parent, returns a new zipper)
- `set_value` (set the value of the focus node, returns a new zipper)
- `insert_before` (insert a new subtree before the focus node, it
  becomes the `prev` of the focus node, returns a new zipper)
- `insert_after` (insert a new subtree after the focus node, it becomes
  the `next` of the focus node, returns a new zipper)
- `delete` (removes the focus node and all subtrees, focus moves to the
  `next` node if possible otherwise to the `prev` node if possible,
  otherwise to the parent node, returns a new zipper)

## Hint

TBD

"
Class {
	#name : #ZipperTest,
	#superclass : #ExercismTest,
	#instVars : [
		'zipperCalculator'
	],
	#category : #'ExercismWIP-Zipper'
}

{ #category : #config }
ZipperTest class >> uuid [
	"Answer a unique id for this exercise"
	^'ba9dd2bb-8040-0d00-8119-74f801deb008'
]

{ #category : #config }
ZipperTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.1.0'
]

{ #category : #setup }
ZipperTest >> setUp [
	zipperCalculator := Zipper new
]

{ #category : #tests }
ZipperTest >> test01_DataIsRetained [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test02_LeftRightAndValue [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'right'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'value'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->3); add: ('type'->'int'); yourself)
]

{ #category : #tests }
ZipperTest >> test03_DeadEnd [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'left'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->nil); add: ('type'->'zipper'); yourself)
]

{ #category : #tests }
ZipperTest >> test04_TreeFromDeepFocus [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'right'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test05_TraversingUpFromTop [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('operation'->'up'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->nil); add: ('type'->'zipper'); yourself)
]

{ #category : #tests }
ZipperTest >> test06_LeftRightAndUp [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 7) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'up'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'right'); yourself); at: 4 put: ((Dictionary new) add: ('operation'->'up'); yourself); at: 5 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 6 put: ((Dictionary new) add: ('operation'->'right'); yourself); at: 7 put: ((Dictionary new) add: ('operation'->'value'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->3); add: ('type'->'int'); yourself)
]

{ #category : #tests }
ZipperTest >> test07_Set_value [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('item'->5); add: ('operation'->'set_value'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->5); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test08_Set_valueAfterTraversingUp [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 5) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'right'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'up'); yourself); at: 4 put: ((Dictionary new) add: ('item'->5); add: ('operation'->'set_value'); yourself); at: 5 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->5); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test09_Set_leftWithLeaf [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('item'->((Dictionary new) add: ('value'->5); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('operation'->'set_left'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->5); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test10_Set_rightWithNull [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('item'->nil); add: ('operation'->'set_right'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test11_Set_rightWithSubtree [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('item'->((Dictionary new) add: ('value'->6); add: ('right'->((Dictionary new) add: ('value'->8); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->7); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)); add: ('operation'->'set_right'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->6); add: ('right'->((Dictionary new) add: ('value'->8); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->7); add: ('right'->nil); add: ('left'->nil); yourself)); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test12_Set_valueOnDeepFocus [
	| result |

	result := zipperCalculator expectedValueOperations: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'right'); yourself); at: 3 put: ((Dictionary new) add: ('item'->5); add: ('operation'->'set_value'); yourself); at: 4 put: ((Dictionary new) add: ('operation'->'to_tree'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('value'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->5); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself)); add: ('type'->'tree'); yourself)
]

{ #category : #tests }
ZipperTest >> test13_DifferentPathsToSameZipper [
	| result |

	result := zipperCalculator sameResultFromOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('operation'->'left'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'up'); yourself); at: 3 put: ((Dictionary new) add: ('operation'->'right'); yourself); yourself) initialTree: ((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('operations'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('operation'->'right'); yourself); yourself)); add: ('initialTree'->((Dictionary new) add: ('value'->1); add: ('right'->((Dictionary new) add: ('value'->4); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->((Dictionary new) add: ('value'->2); add: ('right'->((Dictionary new) add: ('value'->3); add: ('right'->nil); add: ('left'->nil); yourself)); add: ('left'->nil); yourself)); yourself)); add: ('type'->'zipper'); yourself)
]
