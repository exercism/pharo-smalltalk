"
# Largest Series Product

Given a string of digits, calculate the largest product for a contiguous
substring of digits of length n.

For example, for the input `'1027839564'`, the largest product for a
series of 3 digits is 270 (9 * 5 * 6), and the largest product for a
series of 5 digits is 7560 (7 * 8 * 3 * 9 * 5).

Note that these series are only required to occupy *adjacent positions*
in the input; the digits need not be *numerically consecutive*.

For the input `'73167176531330624919225119674426574742355349194934'`,
the largest product for a series of 6 digits is 23520.

## Hint

TBD

"
Class {
	#name : #LargestSeriesProductTest,
	#superclass : #ExercismTest,
	#instVars : [
		'largestSeriesProductCalculator'
	],
	#category : #'ExercismWIP-LargestSeriesProduct'
}

{ #category : #config }
LargestSeriesProductTest class >> uuid [
	"Answer a unique id for this exercise"
	^'3f9afbd9-2b3f-0d00-a2d5-3bb709f0590c'
]

{ #category : #config }
LargestSeriesProductTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
LargestSeriesProductTest >> setUp [
	largestSeriesProductCalculator := LargestSeriesProduct new
]

{ #category : #test }
LargestSeriesProductTest >> testCanFindTheLargestProductOf2 [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '576802143' .
	self assert: result equals: 48
]

{ #category : #test }
LargestSeriesProductTest >> testCanFindTheLargestProductOf2WithNumbersInOrder [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '0123456789' .
	self assert: result equals: 72
]

{ #category : #test }
LargestSeriesProductTest >> testCanFindTheLargestProductOf3 [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 3 digits: '1027839564' .
	self assert: result equals: 270
]

{ #category : #test }
LargestSeriesProductTest >> testCanFindTheLargestProductOf3WithNumbersInOrder [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 3 digits: '0123456789' .
	self assert: result equals: 504
]

{ #category : #test }
LargestSeriesProductTest >> testCanFindTheLargestProductOf5WithNumbersInOrder [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 5 digits: '0123456789' .
	self assert: result equals: 15120
]

{ #category : #test }
LargestSeriesProductTest >> testCanGetTheLargestProductOfABigNumber [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 6 digits: '73167176531330624919225119674426574742355349194934' .
	self assert: result equals: 23520
]

{ #category : #test }
LargestSeriesProductTest >> testFindsTheLargestProductIfSpanEqualsLength [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '29' .
	self assert: result equals: 18
]

{ #category : #test }
LargestSeriesProductTest >> testRejectsEmptyStringAndNonzeroSpan [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 1 digits: '' .
	self assert: result equals: ((Dictionary new) add: ('error'->'span must be smaller than string length'); yourself)
]

{ #category : #test }
LargestSeriesProductTest >> testRejectsInvalidCharacterInDigits [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '1234a5' .
	self assert: result equals: ((Dictionary new) add: ('error'->'digits input must only contain digits'); yourself)
]

{ #category : #test }
LargestSeriesProductTest >> testRejectsNegativeSpan [
	| result |

	result := largestSeriesProductCalculator largestProductSpan:  -1 digits: '12345' .
	self assert: result equals: ((Dictionary new) add: ('error'->'span must be greater than zero'); yourself)
]

{ #category : #test }
LargestSeriesProductTest >> testRejectsSpanLongerThanStringLength [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 4 digits: '123' .
	self assert: result equals: ((Dictionary new) add: ('error'->'span must be smaller than string length'); yourself)
]

{ #category : #test }
LargestSeriesProductTest >> testReports1ForEmptyStringAndEmptyProduct0Span [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 0 digits: '' .
	self assert: result equals: 1
]

{ #category : #test }
LargestSeriesProductTest >> testReports1ForNonemptyStringAndEmptyProduct0Span [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 0 digits: '123' .
	self assert: result equals: 1
]

{ #category : #test }
LargestSeriesProductTest >> testReportsZeroIfAllSpansIncludeZero [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 3 digits: '99099' .
	self assert: result equals: 0
]

{ #category : #test }
LargestSeriesProductTest >> testReportsZeroIfTheOnlyDigitsAreZero [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '0000' .
	self assert: result equals: 0
]
