"
# Sublist

Given two lists determine if the first list is contained within the second
list, if the second list is contained within the first list, if both lists are
contained within each other or if none of these are true.

Specifically, a list A is a sublist of list B if by dropping 0 or more elements
from the front of B and 0 or more elements from the back of B you get a list
that's completely equal to A.

Examples:

 * A = [1, 2, 3], B = [1, 2, 3, 4, 5], A is a sublist of B
 * A = [3, 4, 5], B = [1, 2, 3, 4, 5], A is a sublist of B
 * A = [3, 4], B = [1, 2, 3, 4, 5], A is a sublist of B
 * A = [1, 2, 3], B = [1, 2, 3], A is equal to B
 * A = [1, 2, 3, 4, 5], B = [2, 3, 4], A is a superlist of B
 * A = [1, 2, 4], B = [1, 2, 3, 4, 5], A is not a superlist of, sublist of or equal to B

## Hint

TBD

"
Class {
	#name : #SublistTest,
	#superclass : #ExercismTest,
	#instVars : [
		'sublistCalculator'
	],
	#category : #'ExercismWIP-Sublist'
}

{ #category : #config }
SublistTest class >> uuid [
	"Answer a unique id for this exercise"
	^'8c5328da-2b3f-0d00-a2fd-5d1409f0590c'
]

{ #category : #config }
SublistTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
SublistTest >> setUp [
	sublistCalculator := Sublist new
]

{ #category : #test }
SublistTest >> testAtEndOfSuperlist [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 3 4 5 ) listTwo: #(3 4 5 ) .
	self assert: result equals: 'superlist'
]

{ #category : #test }
SublistTest >> testAtStartOfSuperlist [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 3 4 5 ) listTwo: #(0 1 2 ) .
	self assert: result equals: 'superlist'
]

{ #category : #test }
SublistTest >> testConsecutive [
	| result |

	result := sublistCalculator sublistListOne: #(1 1 2 ) listTwo: #(0 1 1 1 2 1 2 ) .
	self assert: result equals: 'sublist'
]

{ #category : #test }
SublistTest >> testDifferentLists [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(2 3 4 ) .
	self assert: result equals: 'unequal'
]

{ #category : #test }
SublistTest >> testEmptyListWithinNonEmptyList [
	| result |

	result := sublistCalculator sublistListOne: #() listTwo: #(1 2 3 ) .
	self assert: result equals: 'sublist'
]

{ #category : #test }
SublistTest >> testEmptyLists [
	| result |

	result := sublistCalculator sublistListOne: #() listTwo: #() .
	self assert: result equals: 'equal'
]

{ #category : #test }
SublistTest >> testFalseStart [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 5 ) listTwo: #(0 1 2 3 1 2 5 6 ) .
	self assert: result equals: 'sublist'
]

{ #category : #test }
SublistTest >> testFirstListMissingElementFromSecondList [
	| result |

	result := sublistCalculator sublistListOne: #(1 3 ) listTwo: #(1 2 3 ) .
	self assert: result equals: 'unequal'
]

{ #category : #test }
SublistTest >> testInMiddleOfSuperlist [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 3 4 5 ) listTwo: #(2 3 ) .
	self assert: result equals: 'superlist'
]

{ #category : #test }
SublistTest >> testListEqualsItself [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(1 2 3 ) .
	self assert: result equals: 'equal'
]

{ #category : #test }
SublistTest >> testNonEmptyListContainsEmptyList [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #() .
	self assert: result equals: 'superlist'
]

{ #category : #test }
SublistTest >> testOrderMattersToAList [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(3 2 1 ) .
	self assert: result equals: 'unequal'
]

{ #category : #test }
SublistTest >> testSameDigitsButDifferentNumbers [
	| result |

	result := sublistCalculator sublistListOne: #(1 0 1 ) listTwo: #(10 1 ) .
	self assert: result equals: 'unequal'
]

{ #category : #test }
SublistTest >> testSecondListMissingElementFromFirstList [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(1 3 ) .
	self assert: result equals: 'unequal'
]

{ #category : #test }
SublistTest >> testSublistAtEnd [
	| result |

	result := sublistCalculator sublistListOne: #(3 4 5 ) listTwo: #(0 1 2 3 4 5 ) .
	self assert: result equals: 'sublist'
]

{ #category : #test }
SublistTest >> testSublistAtStart [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 ) listTwo: #(0 1 2 3 4 5 ) .
	self assert: result equals: 'sublist'
]

{ #category : #test }
SublistTest >> testSublistInMiddle [
	| result |

	result := sublistCalculator sublistListOne: #(2 3 4 ) listTwo: #(0 1 2 3 4 5 ) .
	self assert: result equals: 'sublist'
]
