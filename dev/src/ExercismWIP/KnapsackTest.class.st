"
# Knapsack

In this exercise, let's try to solve a classic problem.

Bob is a thief. After months of careful planning, he finally manages to
crack the security systems of a high-class apartment.

In front of him are many items, each with a value (v) and weight (w). Bob,
of course, wants to maximize the total value he can get; he would gladly
take all of the items if he could. However, to his horror, he realizes that
the knapsack he carries with him can only hold so much weight (W).

Given a knapsack with a specific carrying capacity (W), help Bob determine
the maximum value he can get from the items in the house. Note that Bob can
take only one of each item.

All values given will be strictly positive. Items will be represented as a
list of pairs, `wi` and `vi`, where the first element `wi` is the weight of
the *i*th item and `vi` is the value for that item.

For example:

Items: [
  { ""weight"": 5, ""value"": 10 },
  { ""weight"": 4, ""value"": 40 },
  { ""weight"": 6, ""value"": 30 },
  { ""weight"": 4, ""value"": 50 }
]

Knapsack Limit: 10

For the above, the first item has weight 5 and value 10, the second item has
weight 4 and value 40, and so on.

In this example, Bob should take the second and fourth item to maximize his
value, which, in this case, is 90. He cannot get more than 90 as his
knapsack has a weight limit of 10.

## Hint

TBD

"
Class {
	#name : #KnapsackTest,
	#superclass : #ExercismTest,
	#instVars : [
		'knapsackCalculator'
	],
	#category : #'ExercismWIP-Knapsack'
}

{ #category : #config }
KnapsackTest class >> uuid [
	"Answer a unique id for this exercise"
	^'2eccb916-9d41-0d00-8fd8-92d708866539'
]

{ #category : #config }
KnapsackTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.0.0'
]

{ #category : #setup }
KnapsackTest >> setUp [
	knapsackCalculator := Knapsack new
]

{ #category : #tests }
KnapsackTest >> test01_NoItems [
	| result |

	result := knapsackCalculator maximumValueItems: ((Dictionary new)) maximumWeight: 100 .
	self assert: result equals: 0
]

{ #category : #tests }
KnapsackTest >> test02_OneItemTooHeavy [
	| result |

	result := knapsackCalculator maximumValueItems: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('value'->1); add: ('weight'->100); yourself); yourself) maximumWeight: 10 .
	self assert: result equals: 0
]

{ #category : #tests }
KnapsackTest >> test03_FiveItemscannotBeGreedyByWeight [
	| result |

	result := knapsackCalculator maximumValueItems: ((Array new: 5) at: 1 put: ((Dictionary new) add: ('value'->5); add: ('weight'->2); yourself); at: 2 put: ((Dictionary new) add: ('value'->5); add: ('weight'->2); yourself); at: 3 put: ((Dictionary new) add: ('value'->5); add: ('weight'->2); yourself); at: 4 put: ((Dictionary new) add: ('value'->5); add: ('weight'->2); yourself); at: 5 put: ((Dictionary new) add: ('value'->21); add: ('weight'->10); yourself); yourself) maximumWeight: 10 .
	self assert: result equals: 21
]

{ #category : #tests }
KnapsackTest >> test04_FiveItemscannotBeGreedyByValue [
	| result |

	result := knapsackCalculator maximumValueItems: ((Array new: 5) at: 1 put: ((Dictionary new) add: ('value'->20); add: ('weight'->2); yourself); at: 2 put: ((Dictionary new) add: ('value'->20); add: ('weight'->2); yourself); at: 3 put: ((Dictionary new) add: ('value'->20); add: ('weight'->2); yourself); at: 4 put: ((Dictionary new) add: ('value'->20); add: ('weight'->2); yourself); at: 5 put: ((Dictionary new) add: ('value'->50); add: ('weight'->10); yourself); yourself) maximumWeight: 10 .
	self assert: result equals: 80
]

{ #category : #tests }
KnapsackTest >> test05_ExampleKnapsack [
	| result |

	result := knapsackCalculator maximumValueItems: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('value'->10); add: ('weight'->5); yourself); at: 2 put: ((Dictionary new) add: ('value'->40); add: ('weight'->4); yourself); at: 3 put: ((Dictionary new) add: ('value'->30); add: ('weight'->6); yourself); at: 4 put: ((Dictionary new) add: ('value'->50); add: ('weight'->4); yourself); yourself) maximumWeight: 10 .
	self assert: result equals: 90
]

{ #category : #tests }
KnapsackTest >> test06_8Items [
	| result |

	result := knapsackCalculator maximumValueItems: ((Array new: 8) at: 1 put: ((Dictionary new) add: ('value'->350); add: ('weight'->25); yourself); at: 2 put: ((Dictionary new) add: ('value'->400); add: ('weight'->35); yourself); at: 3 put: ((Dictionary new) add: ('value'->450); add: ('weight'->45); yourself); at: 4 put: ((Dictionary new) add: ('value'->20); add: ('weight'->5); yourself); at: 5 put: ((Dictionary new) add: ('value'->70); add: ('weight'->25); yourself); at: 6 put: ((Dictionary new) add: ('value'->8); add: ('weight'->3); yourself); at: 7 put: ((Dictionary new) add: ('value'->5); add: ('weight'->2); yourself); at: 8 put: ((Dictionary new) add: ('value'->5); add: ('weight'->2); yourself); yourself) maximumWeight: 104 .
	self assert: result equals: 900
]

{ #category : #tests }
KnapsackTest >> test07_15Items [
	| result |

	result := knapsackCalculator maximumValueItems: ((Array new: 15) at: 1 put: ((Dictionary new) add: ('value'->135); add: ('weight'->70); yourself); at: 2 put: ((Dictionary new) add: ('value'->139); add: ('weight'->73); yourself); at: 3 put: ((Dictionary new) add: ('value'->149); add: ('weight'->77); yourself); at: 4 put: ((Dictionary new) add: ('value'->150); add: ('weight'->80); yourself); at: 5 put: ((Dictionary new) add: ('value'->156); add: ('weight'->82); yourself); at: 6 put: ((Dictionary new) add: ('value'->163); add: ('weight'->87); yourself); at: 7 put: ((Dictionary new) add: ('value'->173); add: ('weight'->90); yourself); at: 8 put: ((Dictionary new) add: ('value'->184); add: ('weight'->94); yourself); at: 9 put: ((Dictionary new) add: ('value'->192); add: ('weight'->98); yourself); at: 10 put: ((Dictionary new) add: ('value'->201); add: ('weight'->106); yourself); at: 11 put: ((Dictionary new) add: ('value'->210); add: ('weight'->110); yourself); at: 12 put: ((Dictionary new) add: ('value'->214); add: ('weight'->113); yourself); at: 13 put: ((Dictionary new) add: ('value'->221); add: ('weight'->115); yourself); at: 14 put: ((Dictionary new) add: ('value'->229); add: ('weight'->118); yourself); at: 15 put: ((Dictionary new) add: ('value'->240); add: ('weight'->120); yourself); yourself) maximumWeight: 750 .
	self assert: result equals: 1458
]
