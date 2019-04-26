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
	^'77e0b22e-b043-0d00-925e-07fa02a76407'
]

{ #category : #config }
LargestSeriesProductTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.2.0'
]

{ #category : #setup }
LargestSeriesProductTest >> setUp [
	largestSeriesProductCalculator := LargestSeriesProduct new
]

{ #category : #tests }
LargestSeriesProductTest >> test01_FindsTheLargestProductIfSpanEqualsLength [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '29' .
	self assert: result equals: 18
]

{ #category : #tests }
LargestSeriesProductTest >> test02_CanFindTheLargestProductOf2WithNumbersInOrder [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '0123456789' .
	self assert: result equals: 72
]

{ #category : #tests }
LargestSeriesProductTest >> test03_CanFindTheLargestProductOf2 [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '576802143' .
	self assert: result equals: 48
]

{ #category : #tests }
LargestSeriesProductTest >> test04_CanFindTheLargestProductOf3WithNumbersInOrder [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 3 digits: '0123456789' .
	self assert: result equals: 504
]

{ #category : #tests }
LargestSeriesProductTest >> test05_CanFindTheLargestProductOf3 [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 3 digits: '1027839564' .
	self assert: result equals: 270
]

{ #category : #tests }
LargestSeriesProductTest >> test06_CanFindTheLargestProductOf5WithNumbersInOrder [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 5 digits: '0123456789' .
	self assert: result equals: 15120
]

{ #category : #tests }
LargestSeriesProductTest >> test07_CanGetTheLargestProductOfABigNumber [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 6 digits: '73167176531330624919225119674426574742355349194934' .
	self assert: result equals: 23520
]

{ #category : #tests }
LargestSeriesProductTest >> test08_ReportsZeroIfTheOnlyDigitsAreZero [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 2 digits: '0000' .
	self assert: result equals: 0
]

{ #category : #tests }
LargestSeriesProductTest >> test09_ReportsZeroIfAllSpansIncludeZero [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 3 digits: '99099' .
	self assert: result equals: 0
]

{ #category : #tests }
LargestSeriesProductTest >> test10_RejectsSpanLongerThanStringLength [
	| result |

	self
		should: [ result := largestSeriesProductCalculator largestProductSpan: 4 digits: '123' ]
		raise: Error
		whoseDescriptionIncludes: 'span must be smaller than string length'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
LargestSeriesProductTest >> test11_Reports1ForEmptyStringAndEmptyProduct0Span [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 0 digits: '' .
	self assert: result equals: 1
]

{ #category : #tests }
LargestSeriesProductTest >> test12_Reports1ForNonemptyStringAndEmptyProduct0Span [
	| result |

	result := largestSeriesProductCalculator largestProductSpan: 0 digits: '123' .
	self assert: result equals: 1
]

{ #category : #tests }
LargestSeriesProductTest >> test13_RejectsEmptyStringAndNonzeroSpan [
	| result |

	self
		should: [ result := largestSeriesProductCalculator largestProductSpan: 1 digits: '' ]
		raise: Error
		whoseDescriptionIncludes: 'span must be smaller than string length'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
LargestSeriesProductTest >> test14_RejectsInvalidCharacterInDigits [
	| result |

	self
		should: [ result := largestSeriesProductCalculator largestProductSpan: 2 digits: '1234a5' ]
		raise: Error
		whoseDescriptionIncludes: 'digits input must only contain digits'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
LargestSeriesProductTest >> test15_RejectsNegativeSpan [
	| result |

	self
		should: [ result := largestSeriesProductCalculator largestProductSpan:  -1 digits: '12345' ]
		raise: Error
		whoseDescriptionIncludes: 'span must be greater than zero'
		description: 'Should get an error with the correct description'
]
