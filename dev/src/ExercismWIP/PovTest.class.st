"
# Pov

Reparent a graph on a selected node.

This exercise is all about re-orientating a graph to see things from a different
point of view. For example family trees are usually presented from the
ancestor's perspective:

```text
    +------0------+
    |      |      |
  +-1-+  +-2-+  +-3-+
  |   |  |   |  |   |
  4   5  6   7  8   9
```

But the same information can be presented from the perspective of any other node
in the graph, by pulling it up to the root and dragging its relationships along
with it. So the same graph from 6's perspective would look like:

```text
        6
        |
  +-----2-----+
  |           |
  7     +-----0-----+
        |           |
      +-1-+       +-3-+
      |   |       |   |
      4   5       8   9
```

This lets us more simply describe the paths between two nodes. So for example
the path from 6-9 (which in the first graph goes up to the root and then down to
a different leaf node) can be seen to follow the path 6-2-0-3-9

This exercise involves taking an input graph and re-orientating it from the point
of view of one of the nodes.

## Hint

TBD

"
Class {
	#name : 'PovTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'povCalculator'
	],
	#category : 'ExercismWIP-Pov',
	#package : 'ExercismWIP',
	#tag : 'Pov'
}

{ #category : 'config' }
PovTest class >> uuid [
	"Answer a unique id for this exercise"
	^'bb0da316-9d41-0d00-8fc5-87d008866539'
]

{ #category : 'config' }
PovTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.3.0'
]

{ #category : 'running' }
PovTest >> setUp [
	super setUp.
	povCalculator := Pov new
]

{ #category : 'tests' }
PovTest >> test01_RerootATreeSoThatItsRootIsTheSpecifiedNodeResultsInTheSameTreeIfTheInputTreeIsASingleton [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'x'); yourself) from: 'x' .
	self assert: result equals: ((Dictionary new) add: ('label'->'x'); yourself)
]

{ #category : 'tests' }
PovTest >> test02_RerootATreeSoThatItsRootIsTheSpecifiedNodeCanRerootATreeWithAParentAndOneSibling [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'x'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling'); yourself); yourself)); yourself) from: 'x' .
	self assert: result equals: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'sibling'); yourself); yourself)); yourself); yourself)); yourself)
]

{ #category : 'tests' }
PovTest >> test03_RerootATreeSoThatItsRootIsTheSpecifiedNodeCanRerootATreeWithAParentAndManySiblings [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 4) at: 1 put: ((Dictionary new) add: ('label'->'a'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'x'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'b'); yourself); at: 4 put: ((Dictionary new) add: ('label'->'c'); yourself); yourself)); yourself) from: 'x' .
	self assert: result equals: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'a'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'b'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'c'); yourself); yourself)); yourself); yourself)); yourself)
]

{ #category : 'tests' }
PovTest >> test04_RerootATreeSoThatItsRootIsTheSpecifiedNodeCanRerootATreeWithNewRootDeeplyNestedInTree [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'level-0'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'level-1'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'level-2'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'level-3'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'x'); yourself); yourself)); yourself); yourself)); yourself); yourself)); yourself); yourself)); yourself) from: 'x' .
	self assert: result equals: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'level-3'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'level-2'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'level-1'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'level-0'); yourself); yourself)); yourself); yourself)); yourself); yourself)); yourself); yourself)); yourself)
]

{ #category : 'tests' }
PovTest >> test05_RerootATreeSoThatItsRootIsTheSpecifiedNodeMovesChildrenOfTheNewRootToSameLevelAsFormerParent [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); yourself)); yourself); yourself)); yourself) from: 'x' .
	self assert: result equals: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'parent'); yourself); yourself)); yourself)
]

{ #category : 'tests' }
PovTest >> test06_RerootATreeSoThatItsRootIsTheSpecifiedNodeCanRerootAComplexTreeWithCousins [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'grandparent'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); yourself)); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling-0'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'sibling-1'); yourself); yourself)); yourself); at: 2 put: ((Dictionary new) add: ('label'->'uncle'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'cousin-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'cousin-1'); yourself); yourself)); yourself); yourself)); yourself) from: 'x' .
	self assert: result equals: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'sibling-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling-1'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'grandparent'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'uncle'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'cousin-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'cousin-1'); yourself); yourself)); yourself); yourself)); yourself); yourself)); yourself); yourself)); yourself)
]

{ #category : 'tests' }
PovTest >> test07_RerootATreeSoThatItsRootIsTheSpecifiedNodeErrorsIfTargetDoesNotExistInASingletonTree [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'x'); yourself) from: 'nonexistent' .
	self assert: result equals: nil
]

{ #category : 'tests' }
PovTest >> test08_RerootATreeSoThatItsRootIsTheSpecifiedNodeErrorsIfTargetDoesNotExistInALargeTree [
	| result |

	result := povCalculator fromPovTree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); yourself)); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling-0'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'sibling-1'); yourself); yourself)); yourself) from: 'nonexistent' .
	self assert: result equals: nil
]

{ #category : 'tests' }
PovTest >> test09_GivenTwoNodesFindThePathBetweenThemCanFindPathToParent [
	| result |

	result := povCalculator pathToFrom: 'x' to: 'parent' tree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'x'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling'); yourself); yourself)); yourself) .
	self assert: result equals: #('x' 'parent' )
]

{ #category : 'tests' }
PovTest >> test10_GivenTwoNodesFindThePathBetweenThemCanFindPathToSibling [
	| result |

	result := povCalculator pathToFrom: 'x' to: 'b' tree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 4) at: 1 put: ((Dictionary new) add: ('label'->'a'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'x'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'b'); yourself); at: 4 put: ((Dictionary new) add: ('label'->'c'); yourself); yourself)); yourself) .
	self assert: result equals: #('x' 'parent' 'b' )
]

{ #category : 'tests' }
PovTest >> test11_GivenTwoNodesFindThePathBetweenThemCanFindPathToCousin [
	| result |

	result := povCalculator pathToFrom: 'x' to: 'cousin-1' tree: ((Dictionary new) add: ('label'->'grandparent'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); yourself)); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling-0'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'sibling-1'); yourself); yourself)); yourself); at: 2 put: ((Dictionary new) add: ('label'->'uncle'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'cousin-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'cousin-1'); yourself); yourself)); yourself); yourself)); yourself) .
	self assert: result equals: #('x' 'parent' 'grandparent' 'uncle' 'cousin-1' )
]

{ #category : 'tests' }
PovTest >> test12_GivenTwoNodesFindThePathBetweenThemCanFindPathNotInvolvingRoot [
	| result |

	result := povCalculator pathToFrom: 'x' to: 'sibling-1' tree: ((Dictionary new) add: ('label'->'grandparent'); add: ('children'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'x'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling-0'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'sibling-1'); yourself); yourself)); yourself); yourself)); yourself) .
	self assert: result equals: #('x' 'parent' 'sibling-1' )
]

{ #category : 'tests' }
PovTest >> test13_GivenTwoNodesFindThePathBetweenThemCanFindPathFromNodesOtherThanX [
	| result |

	result := povCalculator pathToFrom: 'a' to: 'c' tree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 4) at: 1 put: ((Dictionary new) add: ('label'->'a'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'x'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'b'); yourself); at: 4 put: ((Dictionary new) add: ('label'->'c'); yourself); yourself)); yourself) .
	self assert: result equals: #('a' 'parent' 'c' )
]

{ #category : 'tests' }
PovTest >> test14_GivenTwoNodesFindThePathBetweenThemErrorsIfDestinationDoesNotExist [
	| result |

	result := povCalculator pathToFrom: 'x' to: 'nonexistent' tree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); yourself)); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling-0'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'sibling-1'); yourself); yourself)); yourself) .
	self assert: result equals: nil
]

{ #category : 'tests' }
PovTest >> test15_GivenTwoNodesFindThePathBetweenThemErrorsIfSourceDoesNotExist [
	| result |

	result := povCalculator pathToFrom: 'nonexistent' to: 'x' tree: ((Dictionary new) add: ('label'->'parent'); add: ('children'->((Array new: 3) at: 1 put: ((Dictionary new) add: ('label'->'x'); add: ('children'->((Array new: 2) at: 1 put: ((Dictionary new) add: ('label'->'kid-0'); yourself); at: 2 put: ((Dictionary new) add: ('label'->'kid-1'); yourself); yourself)); yourself); at: 2 put: ((Dictionary new) add: ('label'->'sibling-0'); yourself); at: 3 put: ((Dictionary new) add: ('label'->'sibling-1'); yourself); yourself)); yourself) .
	self assert: result equals: nil
]
