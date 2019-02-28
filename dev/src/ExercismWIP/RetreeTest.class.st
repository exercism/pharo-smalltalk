"
# Retree

Imagine you need to transmit a binary tree to a satellite approaching Alpha
Centauri and you have limited bandwidth. Since the tree has no repeating
items it can be uniquely represented by its [pre-order and in-order traversals][wiki].

Write the software for the satellite to rebuild the tree from the traversals.

A pre-order traversal reads the value of the current node before (hence ""pre"")
reading the left subtree in pre-order. Afterwards the right subtree is read
in pre-order.

An in-order traversal reads the left subtree in-order then the current node and
finally the right subtree in-order. So in order from left to right.

For example the pre-order traversal of this tree is [a, i, x, f, r].
The in-order traversal of this tree is [i, a, f, x, r]

```
  a
 / \
i   x
   / \
  f   r
```

Note: the first item in the pre-order traversal is always the root.

[wiki]: https://en.wikipedia.org/wiki/Tree_traversal

## Hint

TBD

"
Class {
	#name : #RetreeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'retreeCalculator'
	],
	#category : #'ExercismWIP-Retree'
}

{ #category : #config }
RetreeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d1c42dbe-4a3f-0d00-bb1d-02aa071d6982'
]

{ #category : #config }
RetreeTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.0.0'
]

{ #category : #setup }
RetreeTest >> setUp [
	retreeCalculator := Retree new
]

{ #category : #tests }
RetreeTest >> test01_EmptyTree [
	| result |

	result := retreeCalculator treeFromTraversalsPreorder: #() inorder: #() .
	self assert: result equals: ((Dictionary new))
]

{ #category : #tests }
RetreeTest >> test02_TreeWithOneItem [
	| result |

	result := retreeCalculator treeFromTraversalsPreorder: #('a' ) inorder: #('a' ) .
	self assert: result equals: ((Dictionary new) add: ('v'->'a'); add: ('l'->((Dictionary new))); add: ('r'->((Dictionary new))); yourself)
]

{ #category : #tests }
RetreeTest >> test03_TreeWithManyItems [
	| result |

	result := retreeCalculator treeFromTraversalsPreorder: #('a' 'i' 'x' 'f' 'r' ) inorder: #('i' 'a' 'f' 'x' 'r' ) .
	self assert: result equals: ((Dictionary new) add: ('v'->'a'); add: ('l'->((Dictionary new) add: ('v'->'i'); add: ('l'->((Dictionary new))); add: ('r'->((Dictionary new))); yourself)); add: ('r'->((Dictionary new) add: ('v'->'x'); add: ('l'->((Dictionary new) add: ('v'->'f'); add: ('l'->((Dictionary new))); add: ('r'->((Dictionary new))); yourself)); add: ('r'->((Dictionary new) add: ('v'->'r'); add: ('l'->((Dictionary new))); add: ('r'->((Dictionary new))); yourself)); yourself)); yourself)
]

{ #category : #tests }
RetreeTest >> test04_RejectTraversalsOfDifferentLength [
	| result |

	result := retreeCalculator treeFromTraversalsPreorder: #('a' 'b' ) inorder: #('b' 'a' 'r' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'traversals must have the same length'); yourself)
]

{ #category : #tests }
RetreeTest >> test05_RejectInconsistentTraversalsOfSameLength [
	| result |

	result := retreeCalculator treeFromTraversalsPreorder: #('x' 'y' 'z' ) inorder: #('a' 'b' 'c' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'traversals must have the same elements'); yourself)
]

{ #category : #tests }
RetreeTest >> test06_RejectTraversalsWithRepeatedItems [
	| result |

	result := retreeCalculator treeFromTraversalsPreorder: #('a' 'b' 'a' ) inorder: #('b' 'a' 'a' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'traversals must contain unique items'); yourself)
]
