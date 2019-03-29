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
	^'3476d016-9d41-0d00-8feb-6fa208866539'
]

{ #category : #config }
CustomSetTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.3.0'
]

{ #category : #setup }
CustomSetTest >> setUp [
	customSetCalculator := CustomSet new
]

{ #category : #tests }
CustomSetTest >> test01_ReturnsTrueIfTheSetContainsNoElementsSetsWithNoElementsAreEmpty [
	| result |

	result := customSetCalculator emptySet: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test02_ReturnsTrueIfTheSetContainsNoElementsSetsWithElementsAreNotEmpty [
	| result |

	result := customSetCalculator emptySet: #(1 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test03_SetsCanReportIfTheyContainAnElementNothingIsContainedInAnEmptySet [
	| result |

	result := customSetCalculator containsSet: #() element: 1 .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test04_SetsCanReportIfTheyContainAnElementWhenTheElementIsInTheSet [
	| result |

	result := customSetCalculator containsSet: #(1 2 3 ) element: 1 .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test05_SetsCanReportIfTheyContainAnElementWhenTheElementIsNotInTheSet [
	| result |

	result := customSetCalculator containsSet: #(1 2 3 ) element: 4 .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test06_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetEmptySetIsASubsetOfAnotherEmptySet [
	| result |

	result := customSetCalculator subsetSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test07_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetEmptySetIsASubsetOfNonemptySet [
	| result |

	result := customSetCalculator subsetSet1: #() set2: #(1 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test08_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetNonemptySetIsNotASubsetOfEmptySet [
	| result |

	result := customSetCalculator subsetSet1: #(1 ) set2: #() .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test09_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsASubsetOfSetWithExactSameElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(1 2 3 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test10_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsASubsetOfLargerSetWithSameElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(4 1 2 3 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test11_ASetIsASubsetIfAllOfItsElementsAreContainedInTheOtherSetSetIsNotASubsetOfSetThatDoesNotContainItsElements [
	| result |

	result := customSetCalculator subsetSet1: #(1 2 3 ) set2: #(4 1 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test12_SetsAreDisjointIfTheyShareNoElementsTheEmptySetIsDisjointWithItself [
	| result |

	result := customSetCalculator disjointSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test13_SetsAreDisjointIfTheyShareNoElementsEmptySetIsDisjointWithNonemptySet [
	| result |

	result := customSetCalculator disjointSet1: #() set2: #(1 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test14_SetsAreDisjointIfTheyShareNoElementsNonemptySetIsDisjointWithEmptySet [
	| result |

	result := customSetCalculator disjointSet1: #(1 ) set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test15_SetsAreDisjointIfTheyShareNoElementsSetsAreNotDisjointIfTheyShareAnElement [
	| result |

	result := customSetCalculator disjointSet1: #(1 2 ) set2: #(2 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test16_SetsAreDisjointIfTheyShareNoElementsSetsAreDisjointIfTheyShareNoElements [
	| result |

	result := customSetCalculator disjointSet1: #(1 2 ) set2: #(3 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test17_SetsWithTheSameElementsAreEqualEmptySetsAreEqual [
	| result |

	result := customSetCalculator equalSet1: #() set2: #() .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test18_SetsWithTheSameElementsAreEqualEmptySetIsNotEqualToNonemptySet [
	| result |

	result := customSetCalculator equalSet1: #() set2: #(1 2 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test19_SetsWithTheSameElementsAreEqualNonemptySetIsNotEqualToEmptySet [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #() .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test20_SetsWithTheSameElementsAreEqualSetsWithTheSameElementsAreEqual [
	| result |

	result := customSetCalculator equalSet1: #(1 2 ) set2: #(2 1 ) .
	self assert: result equals: true
]

{ #category : #tests }
CustomSetTest >> test21_SetsWithTheSameElementsAreEqualSetsWithDifferentElementsAreNotEqual [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #(1 2 4 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test22_SetsWithTheSameElementsAreEqualSetIsNotEqualToLargerSetWithSameElements [
	| result |

	result := customSetCalculator equalSet1: #(1 2 3 ) set2: #(1 2 3 4 ) .
	self assert: result equals: false
]

{ #category : #tests }
CustomSetTest >> test23_UniqueElementsCanBeAddedToASetAddToEmptySet [
	| result |

	result := customSetCalculator addSet: #() element: 3 .
	self assert: result equals: #(3 )
]

{ #category : #tests }
CustomSetTest >> test24_UniqueElementsCanBeAddedToASetAddToNonemptySet [
	| result |

	result := customSetCalculator addSet: #(1 2 4 ) element: 3 .
	self assert: result equals: #(1 2 3 4 )
]

{ #category : #tests }
CustomSetTest >> test25_UniqueElementsCanBeAddedToASetAddingAnExistingElementDoesNotChangeTheSet [
	| result |

	result := customSetCalculator addSet: #(1 2 3 ) element: 3 .
	self assert: result equals: #(1 2 3 )
]

{ #category : #tests }
CustomSetTest >> test26_IntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test27_IntersectionReturnsASetOfAllSharedElementsIntersectionOfAnEmptySetAndNonemptySetIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #() set2: #(3 2 5 ) .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test28_IntersectionReturnsASetOfAllSharedElementsIntersectionOfANonemptySetAndAnEmptySetIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 4 ) set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test29_IntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoSetsWithNoSharedElementsIsAnEmptySet [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 ) set2: #(4 5 6 ) .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test30_IntersectionReturnsASetOfAllSharedElementsIntersectionOfTwoSetsWithSharedElementsIsASetOfTheSharedElements [
	| result |

	result := customSetCalculator intersectionSet1: #(1 2 3 4 ) set2: #(3 2 5 ) .
	self assert: result equals: #(2 3 )
]

{ #category : #tests }
CustomSetTest >> test31_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfTwoEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator differenceSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test32_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfEmptySetAndNonemptySetIsAnEmptySet [
	| result |

	result := customSetCalculator differenceSet1: #() set2: #(3 2 5 ) .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test33_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfANonemptySetAndAnEmptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator differenceSet1: #(1 2 3 4 ) set2: #() .
	self assert: result equals: #(1 2 3 4 )
]

{ #category : #tests }
CustomSetTest >> test34_DifferenceorComplementOfASetIsASetOfAllElementsThatAreOnlyInTheFirstSetDifferenceOfTwoNonemptySetsIsASetOfElementsThatAreOnlyInTheFirstSet [
	| result |

	result := customSetCalculator differenceSet1: #(3 2 1 ) set2: #(2 4 ) .
	self assert: result equals: #(1 3 )
]

{ #category : #tests }
CustomSetTest >> test35_UnionReturnsASetOfAllElementsInEitherSetUnionOfEmptySetsIsAnEmptySet [
	| result |

	result := customSetCalculator unionSet1: #() set2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
CustomSetTest >> test36_UnionReturnsASetOfAllElementsInEitherSetUnionOfAnEmptySetAndNonemptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator unionSet1: #() set2: #(2 ) .
	self assert: result equals: #(2 )
]

{ #category : #tests }
CustomSetTest >> test37_UnionReturnsASetOfAllElementsInEitherSetUnionOfANonemptySetAndEmptySetIsTheNonemptySet [
	| result |

	result := customSetCalculator unionSet1: #(1 3 ) set2: #() .
	self assert: result equals: #(1 3 )
]

{ #category : #tests }
CustomSetTest >> test38_UnionReturnsASetOfAllElementsInEitherSetUnionOfNonemptySetsContainsAllUniqueElements [
	| result |

	result := customSetCalculator unionSet1: #(1 3 ) set2: #(2 3 ) .
	self assert: result equals: #(3 2 1 )
]
