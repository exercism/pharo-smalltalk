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
	^'14c762be-4a3f-0d00-bb41-2664071d6982'
]

{ #category : #config }
CustomSetTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.3.0'
]

{ #category : #setup }
CustomSetTest >> setUp [
	customSetCalculator := CustomSet new
]

{ #category : #tests }
CustomSetTest >> test01_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetEmptySetIsASubsetOfAnotherEmptySet [
	| result |

	result := customSetCalculator subsetSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test01_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfTwoEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator differenceSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test01_IntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test01_ReturnsTrueIfTheSetContainsNoElementsSetsWithNoElementsAreEmpty [
	| result |

	result := customSetCalculator emptySet: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test01_SetsAreDisjointIfTheyShareNoElementsTheEmptySetIsDisjointWithItself [
	| result |

	result := customSetCalculator disjointSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test01_SetsCanReportIfTheyContainAnElementNothingIsContainedInAnEmptySet [
	| result |

	result := customSetCalculator containsSet: #() element: 1 .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test01_SetsWithTheSameElementsAreEqualEmptySetsAreEqual [
	| result |

	result := customSetCalculator equalSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test01_UnionReturnsASetOfAllElementsInEitherSetUnionOfEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator unionSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test01_UniqueElementsCanBeAddedToASetAddToEmptySet [
	| result |

	result := customSetCalculator addSet: #() element: 3 .
	self assert: result equals: #(3 )
]

{ #category : #tests }
CustomSetTest >> test02_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetEmptySetIsASubsetOfNonemptySet [
	| result |

	result := customSetCalculator subsetSet1: #() set2: #(1 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test02_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfEmptySetAndNonemptySetIsAnEmptySet [
	| result |

	result := customSetCalculator differenceSet1: #() set2: #(3 2 5 ) .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test02_IntersectionReturnsASetOfAllSharedElementsIntersectionOfAnEmptySetAndNonemptySetIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #() set2: #(3 2 5 ) .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test02_ReturnsTrueIfTheSetContainsNoElementsSetsWithElementsAreNotEmpty [
	| result |

	result := customSetCalculator emptySet: #(1 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test02_SetsAreDisjointIfTheyShareNoElementsEmptySetIsDisjointWithNonemptySet [
	| result |

	result := customSetCalculator disjointSet1: #() set2: #(1 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test02_SetsCanReportIfTheyContainAnElementWhenTheElementIsInTheSet [
	| result |

	result := customSetCalculator containsSet: #(1 2 3 ) element: 1 .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test02_SetsWithTheSameElementsAreEqualEmptySetIsNotEqualToNonemptySet [
	| result |

	result := customSetCalculator equalSet1: #() set2: #(1 2 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test02_UnionReturnsASetOfAllElementsInEitherSetUnionOfAnEmptySetAndNonemptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator unionSet1: #() set2: #(2 ) .
	self assert: result equals: #(2 )
]

{ #category : #tests }
CustomSetTest >> test02_UniqueElementsCanBeAddedToASetAddToNonemptySet [
	| result |

	result := customSetCalculator addSet: #(1 2 4 ) element: 3 .
	self assert: result equals: #(1 2 3 4 )
]

{ #category : #tests }
CustomSetTest >> test03_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetNonemptySetIsNotASubsetOfEmptySet [
	| result |

	result := customSetCalculator subsetSet1: #(1 ) set2: #() .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test03_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfANonemptySetAndAnEmptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator differenceSet1: #(1 2 3 4 ) set2: #() .
	self assert: result equals: #(1 2 3 4 )
]

{ #category : #tests }
CustomSetTest >> test03_IntersectionReturnsASetOfAllSharedElementsIntersectionOfANonemptySetAndAnEmptySetIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 4 ) set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test03_SetsAreDisjointIfTheyShareNoElementsNonemptySetIsDisjointWithEmptySet [
	| result |

	result := customSetCalculator disjointSet1: #(1 ) set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test03_SetsCanReportIfTheyContainAnElementWhenTheElementIsNotInTheSet [
	| result |

	result := customSetCalculator containsSet: #(1 2 3 ) element: 4 .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test03_SetsWithTheSameElementsAreEqualNonemptySetIsNotEqualToEmptySet [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #() .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test03_UnionReturnsASetOfAllElementsInEitherSetUnionOfANonemptySetAndEmptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator unionSet1: #(1 3 ) set2: #() .
	self assert: result equals: #(1 3 )
]

{ #category : #tests }
CustomSetTest >> test03_UniqueElementsCanBeAddedToASetAddingAnExistingElementDoesNotChangeTheSet [
	| result |

	result := customSetCalculator addSet: #(1 2 3 ) element: 3 .
	self assert: result equals: #(1 2 3 )
]

{ #category : #tests }
CustomSetTest >> test04_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsASubsetOfSetWithExactSameElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(1 2 3 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test04_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfTwoNonemptySetsIsASetOfElementsThatAreOnlyInTheFirstSet [
	| result |

	result := customSetCalculator differenceSet1: #(3 2 1 ) set2: #(2 4 ) .
	self assert: result equals: #(1 3 )
]

{ #category : #tests }
CustomSetTest >> test04_IntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoSetsWithNoSharedElementsIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 ) set2: #(4 5 6 ) .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test04_SetsAreDisjointIfTheyShareNoElementsSetsAreNotDisjointIfTheyShareAnElement [
	| result |

	result := customSetCalculator disjointSet1: #(1 2 ) set2: #(2 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test04_SetsWithTheSameElementsAreEqualSetsWithTheSameElementsAreEqual [
	| result |

	result := customSetCalculator equalSet1: #(1 2 ) set2: #(2 1 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test04_UnionReturnsASetOfAllElementsInEitherSetUnionOfNonemptySetsContainsAllUniqueElements [
	| result |

	result := customSetCalculator unionSet1: #(1 3 ) set2: #(2 3 ) .
	self assert: result equals: #(3 2 1 )
]

{ #category : #tests }
CustomSetTest >> test05_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsASubsetOfLargerSetWithSameElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(4 1 2 3 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test05_IntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoSetsWithSharedElementsIsASetOfTheSharedElements [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 4 ) set2: #(3 2 5 ) .
	self assert: result equals: #(2 3 )
]

{ #category : #tests }
CustomSetTest >> test05_SetsAreDisjointIfTheyShareNoElementsSetsAreDisjointIfTheyShareNoElements [
	| result |

	result := customSetCalculator disjointSet1: #(1 2 ) set2: #(3 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test05_SetsWithTheSameElementsAreEqualSetsWithDifferentElementsAreNotEqual [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #(1 2 4 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test06_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsNotASubsetOfSetThatDoesNotContainItsElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(4 1 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test06_SetsWithTheSameElementsAreEqualSetIsNotEqualToLargerSetWithSameElements [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #(1 2 3 4 ) .
	self assert: result equals: false
]
