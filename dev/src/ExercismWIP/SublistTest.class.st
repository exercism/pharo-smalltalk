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
	^'de97f516-9d41-0d00-9004-a58f08866539'
]

{ #category : #config }
SublistTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #running }
SublistTest >> setUp [
	super setUp.
	sublistCalculator := Sublist new
]

{ #category : #tests }
SublistTest >> test01_EmptyLists [
	| result |

	result := sublistCalculator sublistListOne: #() listTwo: #() .
	self assert: result equals: 'equal'
]

{ #category : #tests }
SublistTest >> test02_EmptyListWithinNonEmptyList [
	| result |

	result := sublistCalculator sublistListOne: #() listTwo: #(1 2 3 ) .
	self assert: result equals: 'sublist'
]

{ #category : #tests }
SublistTest >> test03_NonEmptyListContainsEmptyList [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #() .
	self assert: result equals: 'superlist'
]

{ #category : #tests }
SublistTest >> test04_ListEqualsItself [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(1 2 3 ) .
	self assert: result equals: 'equal'
]

{ #category : #tests }
SublistTest >> test05_DifferentLists [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(2 3 4 ) .
	self assert: result equals: 'unequal'
]

{ #category : #tests }
SublistTest >> test06_FalseStart [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 5 ) listTwo: #(0 1 2 3 1 2 5 6 ) .
	self assert: result equals: 'sublist'
]

{ #category : #tests }
SublistTest >> test07_Consecutive [
	| result |

	result := sublistCalculator sublistListOne: #(1 1 2 ) listTwo: #(0 1 1 1 2 1 2 ) .
	self assert: result equals: 'sublist'
]

{ #category : #tests }
SublistTest >> test08_SublistAtStart [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 ) listTwo: #(0 1 2 3 4 5 ) .
	self assert: result equals: 'sublist'
]

{ #category : #tests }
SublistTest >> test09_SublistInMiddle [
	| result |

	result := sublistCalculator sublistListOne: #(2 3 4 ) listTwo: #(0 1 2 3 4 5 ) .
	self assert: result equals: 'sublist'
]

{ #category : #tests }
SublistTest >> test10_SublistAtEnd [
	| result |

	result := sublistCalculator sublistListOne: #(3 4 5 ) listTwo: #(0 1 2 3 4 5 ) .
	self assert: result equals: 'sublist'
]

{ #category : #tests }
SublistTest >> test11_AtStartOfSuperlist [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 3 4 5 ) listTwo: #(0 1 2 ) .
	self assert: result equals: 'superlist'
]

{ #category : #tests }
SublistTest >> test12_InMiddleOfSuperlist [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 3 4 5 ) listTwo: #(2 3 ) .
	self assert: result equals: 'superlist'
]

{ #category : #tests }
SublistTest >> test13_AtEndOfSuperlist [
	| result |

	result := sublistCalculator sublistListOne: #(0 1 2 3 4 5 ) listTwo: #(3 4 5 ) .
	self assert: result equals: 'superlist'
]

{ #category : #tests }
SublistTest >> test14_FirstListMissingElementFromSecondList [
	| result |

	result := sublistCalculator sublistListOne: #(1 3 ) listTwo: #(1 2 3 ) .
	self assert: result equals: 'unequal'
]

{ #category : #tests }
SublistTest >> test15_SecondListMissingElementFromFirstList [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(1 3 ) .
	self assert: result equals: 'unequal'
]

{ #category : #tests }
SublistTest >> test16_OrderMattersToAList [
	| result |

	result := sublistCalculator sublistListOne: #(1 2 3 ) listTwo: #(3 2 1 ) .
	self assert: result equals: 'unequal'
]

{ #category : #tests }
SublistTest >> test17_SameDigitsButDifferentNumbers [
	| result |

	result := sublistCalculator sublistListOne: #(1 0 1 ) listTwo: #(10 1 ) .
	self assert: result equals: 'unequal'
]
