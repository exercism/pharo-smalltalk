"
# List Ops

Implement basic list operations.

In functional languages list operations like `length`, `map`, and
`reduce` are very common. Implement a series of basic list operations,
without using existing functions.

The precise number and names of the operations to be implemented will be 
track dependent to avoid conflicts with existing names, but the general
operations you will implement include:

* `append` (*given two lists, add all items in the second list to the end of the first list*);
* `concatenate` (*given a series of lists, combine all items in all lists into one flattened list*);
* `filter` (*given a predicate and a list, return the list of all items for which `predicate(item)` is True*);
* `length` (*given a list, return the total number of items within it*);
* `map` (*given a function and a list, return the list of the results of applying `function(item)` on all items*);
* `foldl` (*given a function, a list, and initial accumulator, fold (reduce) each item into the accumulator from the left using `function(accumulator, item)`*);
* `foldr` (*given a function, a list, and an initial accumulator, fold (reduce) each item into the accumulator from the right using `function(item, accumulator)`*);
* `reverse` (*given a list, return a list with all the original items, but in reversed order*);

## Hint

TBD

"
Class {
	#name : #ListOpsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'listOpsCalculator'
	],
	#category : #'ExercismWIP-ListOps'
}

{ #category : #config }
ListOpsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'1ca155be-4a3f-0d00-bb3a-d024071d6982'
]

{ #category : #config }
ListOpsTest class >> version [
	"Generated from specification: 28 February 2019"
	^'2.4.0'
]

{ #category : #setup }
ListOpsTest >> setUp [
	listOpsCalculator := ListOps new
]

{ #category : #tests }
ListOpsTest >> test01_AppendEntriesToAListAndReturnTheNewListEmptyLists [
	| result |

	result := listOpsCalculator appendList1: #() list2: #() .
	self assert: result equals: #()
]

{ #category : #tests }
ListOpsTest >> test01_ConcatenateAListOfListsEmptyList [
	| result |

	result := listOpsCalculator concatLists: #() .
	self assert: result equals: #()
]

{ #category : #tests }
ListOpsTest >> test01_FilterListReturningOnlyValuesThatSatisfyTheFilterFunctionEmptyList [
	| result |

	result := listOpsCalculator filterFunction: '(x) -> x modulo 2 == 1' list: #() .
	self assert: result equals: #()
]

{ #category : #tests }
ListOpsTest >> test01_FoldsreducesTheGivenListFromTheLeftWithAFunctionEmptyList [
	| result |

	result := listOpsCalculator foldlFunction: '(x, y) -> x * y' initial: 2 list: #() .
	self assert: result equals: 2
]

{ #category : #tests }
ListOpsTest >> test01_FoldsreducesTheGivenListFromTheRightWithAFunctionEmptyList [
	| result |

	result := listOpsCalculator foldrFunction: '(x, y) -> x * y' initial: 2 list: #() .
	self assert: result equals: 2
]

{ #category : #tests }
ListOpsTest >> test01_ReturnAListOfElementsWhoseValuesEqualTheListValueTransformedByTheMappingFunctionEmptyList [
	| result |

	result := listOpsCalculator mapFunction: '(x) -> x + 1' list: #() .
	self assert: result equals: #()
]

{ #category : #tests }
ListOpsTest >> test01_ReturnsTheLengthOfAListEmptyList [
	| result |

	result := listOpsCalculator lengthList: #() .
	self assert: result equals: 0
]

{ #category : #tests }
ListOpsTest >> test01_ReverseTheElementsOfTheListEmptyList [
	| result |

	result := listOpsCalculator reverseList: #() .
	self assert: result equals: #()
]

{ #category : #tests }
ListOpsTest >> test02_AppendEntriesToAListAndReturnTheNewListEmptyListToList [
	| result |

	result := listOpsCalculator appendList1: #() list2: #(1 2 3 4 ) .
	self assert: result equals: #(1 2 3 4 )
]

{ #category : #tests }
ListOpsTest >> test02_ConcatenateAListOfListsListOfLists [
	| result |

	result := listOpsCalculator concatLists: #(#(1 2 ) #(3 ) #() #(4 5 6 ) ) .
	self assert: result equals: #(1 2 3 4 5 6 )
]

{ #category : #tests }
ListOpsTest >> test02_FilterListReturningOnlyValuesThatSatisfyTheFilterFunctionNonemptyList [
	| result |

	result := listOpsCalculator filterFunction: '(x) -> x modulo 2 == 1' list: #(1 2 3 5 ) .
	self assert: result equals: #(1 3 5 )
]

{ #category : #tests }
ListOpsTest >> test02_FoldsreducesTheGivenListFromTheLeftWithAFunctionDirectionIndependentFunctionAppliedToNonemptyList [
	| result |

	result := listOpsCalculator foldlFunction: '(x, y) -> x + y' initial: 5 list: #(1 2 3 4 ) .
	self assert: result equals: 15
]

{ #category : #tests }
ListOpsTest >> test02_FoldsreducesTheGivenListFromTheRightWithAFunctionDirectionIndependentFunctionAppliedToNonemptyList [
	| result |

	result := listOpsCalculator foldrFunction: '(x, y) -> x + y' initial: 5 list: #(1 2 3 4 ) .
	self assert: result equals: 15
]

{ #category : #tests }
ListOpsTest >> test02_ReturnAListOfElementsWhoseValuesEqualTheListValueTransformedByTheMappingFunctionNonemptyList [
	| result |

	result := listOpsCalculator mapFunction: '(x) -> x + 1' list: #(1 3 5 7 ) .
	self assert: result equals: #(2 4 6 8 )
]

{ #category : #tests }
ListOpsTest >> test02_ReturnsTheLengthOfAListNonemptyList [
	| result |

	result := listOpsCalculator lengthList: #(1 2 3 4 ) .
	self assert: result equals: 4
]

{ #category : #tests }
ListOpsTest >> test02_ReverseTheElementsOfTheListNonemptyList [
	| result |

	result := listOpsCalculator reverseList: #(1 3 5 7 ) .
	self assert: result equals: #(7 5 3 1 )
]

{ #category : #tests }
ListOpsTest >> test03_AppendEntriesToAListAndReturnTheNewListNonemptyLists [
	| result |

	result := listOpsCalculator appendList1: #(1 2 ) list2: #(2 3 4 5 ) .
	self assert: result equals: #(1 2 2 3 4 5 )
]

{ #category : #tests }
ListOpsTest >> test03_ConcatenateAListOfListsListOfNestedLists [
	| result |

	result := listOpsCalculator concatLists: #(#(#(1 ) #(2 ) ) #(#(3 ) ) #(#() ) #(#(4 5 6 ) ) ) .
	self assert: result equals: #(#(1 ) #(2 ) #(3 ) #() #(4 5 6 ) )
]

{ #category : #tests }
ListOpsTest >> test03_FoldsreducesTheGivenListFromTheLeftWithAFunctionDirectionDependentFunctionAppliedToNonemptyList [
	| result |

	result := listOpsCalculator foldlFunction: '(x, y) -> x / y' initial: 5 list: #(2 5 ) .
	self assert: result equals: 0
]

{ #category : #tests }
ListOpsTest >> test03_FoldsreducesTheGivenListFromTheRightWithAFunctionDirectionDependentFunctionAppliedToNonemptyList [
	| result |

	result := listOpsCalculator foldrFunction: '(x, y) -> x / y' initial: 5 list: #(2 5 ) .
	self assert: result equals: 2
]

{ #category : #tests }
ListOpsTest >> test03_ReverseTheElementsOfTheListListOfListsIsNotFlattened [
	| result |

	result := listOpsCalculator reverseList: #(#(1 2 ) #(3 ) #() #(4 5 6 ) ) .
	self assert: result equals: #(#(4 5 6 ) #() #(3 ) #(1 2 ) )
]
