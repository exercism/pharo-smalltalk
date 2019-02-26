"
# Binary Search

Implement a binary search algorithm.

Searching a sorted collection is a common task. A dictionary is a sorted
list of word definitions. Given a word, one can find its definition. A
telephone book is a sorted list of people's names, addresses, and
telephone numbers. Knowing someone's name allows one to quickly find
their telephone number and address.

If the list to be searched contains more than a few items (a dozen, say)
a binary search will require far fewer comparisons than a linear search,
but it imposes the requirement that the list be sorted.

In computer science, a binary search or half-interval search algorithm
finds the position of a specified input value (the search ""key"") within
an array sorted by key value.

In each step, the algorithm compares the search key value with the key
value of the middle element of the array.

If the keys match, then a matching element has been found and its index,
or position, is returned.

Otherwise, if the search key is less than the middle element's key, then
the algorithm repeats its action on the sub-array to the left of the
middle element or, if the search key is greater, on the sub-array to the
right.

If the remaining array to be searched is empty, then the key cannot be
found in the array and a special ""not found"" indication is returned.

A binary search halves the number of items to check with each iteration,
so locating an item (or determining its absence) takes logarithmic time.
A binary search is a dichotomic divide and conquer search algorithm.

## Hint

TBD

"
Class {
	#name : #BinarySearchTest,
	#superclass : #ExercismTest,
	#instVars : [
		'binarySearchCalculator'
	],
	#category : #'ExercismWIP-BinarySearch'
}

{ #category : #config }
BinarySearchTest class >> uuid [
	"Answer a unique id for this exercise"
	^'20c933da-2b3f-0d00-a309-704909f0590c'
]

{ #category : #config }
BinarySearchTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.3.0'
]

{ #category : #setup }
BinarySearchTest >> setUp [
	binarySearchCalculator := BinarySearch new
]

{ #category : #test }
BinarySearchTest >> testAValueLargerThanTheArraysLargestValueIsNotFound [
	| result |

	result := binarySearchCalculator findArray: #(1 3 4 6 8 9 11 ) value: 13 .
	self assert: result equals: ((Dictionary new) add: ('error'->'value not in array'); yourself)
]

{ #category : #test }
BinarySearchTest >> testAValueSmallerThanTheArraysSmallestValueIsNotFound [
	| result |

	result := binarySearchCalculator findArray: #(1 3 4 6 8 9 11 ) value: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'value not in array'); yourself)
]

{ #category : #test }
BinarySearchTest >> testFindsAValueAtTheBeginningOfAnArray [
	| result |

	result := binarySearchCalculator findArray: #(1 3 4 6 8 9 11 ) value: 1 .
	self assert: result equals: 0
]

{ #category : #test }
BinarySearchTest >> testFindsAValueAtTheEndOfAnArray [
	| result |

	result := binarySearchCalculator findArray: #(1 3 4 6 8 9 11 ) value: 11 .
	self assert: result equals: 6
]

{ #category : #test }
BinarySearchTest >> testFindsAValueInAnArrayOfEvenLength [
	| result |

	result := binarySearchCalculator findArray: #(1 3 5 8 13 21 34 55 89 144 233 377 ) value: 21 .
	self assert: result equals: 5
]

{ #category : #test }
BinarySearchTest >> testFindsAValueInAnArrayOfOddLength [
	| result |

	result := binarySearchCalculator findArray: #(1 3 5 8 13 21 34 55 89 144 233 377 634 ) value: 144 .
	self assert: result equals: 9
]

{ #category : #test }
BinarySearchTest >> testFindsAValueInAnArrayWithOneElement [
	| result |

	result := binarySearchCalculator findArray: #(6 ) value: 6 .
	self assert: result equals: 0
]

{ #category : #test }
BinarySearchTest >> testFindsAValueInTheMiddleOfAnArray [
	| result |

	result := binarySearchCalculator findArray: #(1 3 4 6 8 9 11 ) value: 6 .
	self assert: result equals: 3
]

{ #category : #test }
BinarySearchTest >> testIdentifiesThatAValueIsNotIncludedInTheArray [
	| result |

	result := binarySearchCalculator findArray: #(1 3 4 6 8 9 11 ) value: 7 .
	self assert: result equals: ((Dictionary new) add: ('error'->'value not in array'); yourself)
]

{ #category : #test }
BinarySearchTest >> testNothingIsFoundInAnEmptyArray [
	| result |

	result := binarySearchCalculator findArray: #() value: 1 .
	self assert: result equals: ((Dictionary new) add: ('error'->'value not in array'); yourself)
]

{ #category : #test }
BinarySearchTest >> testNothingIsFoundWhenTheLeftAndRightBoundsCross [
	| result |

	result := binarySearchCalculator findArray: #(1 2 ) value: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'value not in array'); yourself)
]
