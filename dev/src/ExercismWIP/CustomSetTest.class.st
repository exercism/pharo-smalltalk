"
# Custom Set

Create a custom set type.

Sometimes it is necessary to define a custom data structure of some
type, like a set. In this exercise you will define your own set. How it
works internally doesn't matter, as long as it behaves like a set of
unique elements.

## Hint

TBD

"
Class {
	#name : #CustomSetTest,
	#superclass : #ExercismTest,
	#instVars : [
		'customSetCalculator'
	],
	#category : #'ExercismWIP-CustomSet'
}

{ #category : #config }
CustomSetTest class >> uuid [
	"Answer a unique id for this exercise"
	^'683503da-2b3f-0d00-a2dd-7b0c09f0590c'
]

{ #category : #config }
CustomSetTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.3.0'
]

{ #category : #setup }
CustomSetTest >> setUp [
	customSetCalculator := CustomSet new
]

{ #category : #test }
CustomSetTest >> testASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetEmptySetIsASubsetOfAnotherEmptySet [
	| result |

	result := customSetCalculator subsetSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetEmptySetIsASubsetOfNonemptySet [
	| result |

	result := customSetCalculator subsetSet1: #() set2: #(1 ) .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetNonemptySetIsNotASubsetOfEmptySet [
	| result |

	result := customSetCalculator subsetSet1: #(1 ) set2: #() .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsASubsetOfLargerSetWithSameElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(4 1 2 3 ) .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsASubsetOfSetWithExactSameElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(1 2 3 ) .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsNotASubsetOfSetThatDoesNotContainItsElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(4 1 3 ) .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testDifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfANonemptySetAndAnEmptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator differenceSet1: #(1 2 3 4 ) set2: #() .
	self assert: result equals: #(1 2 3 4 )
]

{ #category : #test }
CustomSetTest >> testDifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfEmptySetAndNonemptySetIsAnEmptySet [
	| result |

	result := customSetCalculator differenceSet1: #() set2: #(3 2 5 ) .
	self assert: result equals: #()
]

{ #category : #test }
CustomSetTest >> testDifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfTwoEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator differenceSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #test }
CustomSetTest >> testDifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfTwoNonemptySetsIsASetOfElementsThatAreOnlyInTheFirstSet [
	| result |

	result := customSetCalculator differenceSet1: #(3 2 1 ) set2: #(2 4 ) .
	self assert: result equals: #(1 3 )
]

{ #category : #test }
CustomSetTest >> testIntersectionReturnsASetOfAllSharedElementsIntersectionOfANonemptySetAndAnEmptySetIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 4 ) set2: #() .
	self assert: result equals: #()
]

{ #category : #test }
CustomSetTest >> testIntersectionReturnsASetOfAllSharedElementsIntersectionOfAnEmptySetAndNonemptySetIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #() set2: #(3 2 5 ) .
	self assert: result equals: #()
]

{ #category : #test }
CustomSetTest >> testIntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #test }
CustomSetTest >> testIntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoSetsWithNoSharedElementsIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 ) set2: #(4 5 6 ) .
	self assert: result equals: #()
]

{ #category : #test }
CustomSetTest >> testIntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoSetsWithSharedElementsIsASetOfTheSharedElements [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 4 ) set2: #(3 2 5 ) .
	self assert: result equals: #(2 3 )
]

{ #category : #test }
CustomSetTest >> testReturnsTrueIfTheSetContainsNoElementsSetsWithElementsAreNotEmpty [
	| result |

	result := customSetCalculator emptySet: #(1 ) .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testReturnsTrueIfTheSetContainsNoElementsSetsWithNoElementsAreEmpty [
	| result |

	result := customSetCalculator emptySet: #() .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testSetsAreDisjointIfTheyShareNoElementsEmptySetIsDisjointWithNonemptySet [
	| result |

	result := customSetCalculator disjointSet1: #() set2: #(1 ) .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testSetsAreDisjointIfTheyShareNoElementsNonemptySetIsDisjointWithEmptySet [
	| result |

	result := customSetCalculator disjointSet1: #(1 ) set2: #() .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testSetsAreDisjointIfTheyShareNoElementsSetsAreDisjointIfTheyShareNoElements [
	| result |

	result := customSetCalculator disjointSet1: #(1 2 ) set2: #(3 4 ) .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testSetsAreDisjointIfTheyShareNoElementsSetsAreNotDisjointIfTheyShareAnElement [
	| result |

	result := customSetCalculator disjointSet1: #(1 2 ) set2: #(2 3 ) .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testSetsAreDisjointIfTheyShareNoElementsTheEmptySetIsDisjointWithItself [
	| result |

	result := customSetCalculator disjointSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testSetsCanReportIfTheyContainAnElementNothingIsContainedInAnEmptySet [
	| result |

	result := customSetCalculator containsSet: #() element: 1 .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testSetsCanReportIfTheyContainAnElementWhenTheElementIsInTheSet [
	| result |

	result := customSetCalculator containsSet: #(1 2 3 ) element: 1 .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testSetsCanReportIfTheyContainAnElementWhenTheElementIsNotInTheSet [
	| result |

	result := customSetCalculator containsSet: #(1 2 3 ) element: 4 .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testSetsWithTheSameElementsAreEqualEmptySetIsNotEqualToNonemptySet [
	| result |

	result := customSetCalculator equalSet1: #() set2: #(1 2 3 ) .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testSetsWithTheSameElementsAreEqualEmptySetsAreEqual [
	| result |

	result := customSetCalculator equalSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testSetsWithTheSameElementsAreEqualNonemptySetIsNotEqualToEmptySet [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #() .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testSetsWithTheSameElementsAreEqualSetIsNotEqualToLargerSetWithSameElements [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #(1 2 3 4 ) .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testSetsWithTheSameElementsAreEqualSetsWithDifferentElementsAreNotEqual [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #(1 2 4 ) .
	self assert: result equals: false
]

{ #category : #test }
CustomSetTest >> testSetsWithTheSameElementsAreEqualSetsWithTheSameElementsAreEqual [
	| result |

	result := customSetCalculator equalSet1: #(1 2 ) set2: #(2 1 ) .
	self assert: result equals: true
]

{ #category : #test }
CustomSetTest >> testUnionReturnsASetOfAllElementsInEitherSetUnionOfANonemptySetAndEmptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator unionSet1: #(1 3 ) set2: #() .
	self assert: result equals: #(1 3 )
]

{ #category : #test }
CustomSetTest >> testUnionReturnsASetOfAllElementsInEitherSetUnionOfAnEmptySetAndNonemptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator unionSet1: #() set2: #(2 ) .
	self assert: result equals: #(2 )
]

{ #category : #test }
CustomSetTest >> testUnionReturnsASetOfAllElementsInEitherSetUnionOfEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator unionSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #test }
CustomSetTest >> testUnionReturnsASetOfAllElementsInEitherSetUnionOfNonemptySetsContainsAllUniqueElements [
	| result |

	result := customSetCalculator unionSet1: #(1 3 ) set2: #(2 3 ) .
	self assert: result equals: #(3 2 1 )
]

{ #category : #test }
CustomSetTest >> testUniqueElementsCanBeAddedToASetAddToEmptySet [
	| result |

	result := customSetCalculator addSet: #() element: 3 .
	self assert: result equals: #(3 )
]

{ #category : #test }
CustomSetTest >> testUniqueElementsCanBeAddedToASetAddToNonemptySet [
	| result |

	result := customSetCalculator addSet: #(1 2 4 ) element: 3 .
	self assert: result equals: #(1 2 3 4 )
]

{ #category : #test }
CustomSetTest >> testUniqueElementsCanBeAddedToASetAddingAnExistingElementDoesNotChangeTheSet [
	| result |

	result := customSetCalculator addSet: #(1 2 3 ) element: 3 .
	self assert: result equals: #(1 2 3 )
]
