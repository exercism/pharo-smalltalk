"
# Series

Given a string of digits, output all the contiguous substrings of length `n` in
that string in the order that they appear.

For example, the string ""49142"" has the following 3-digit series:

- ""491""
- ""914""
- ""142""

And the following 4-digit series:

- ""4914""
- ""9142""

And if you ask for a 6-digit series from a 5-digit string, you deserve
whatever you get.

Note that these series are only required to occupy *adjacent positions*
in the input; the digits need not be *numerically consecutive*.

## Hint

TBD

"
Class {
	#name : #SeriesTest,
	#superclass : #ExercismTest,
	#instVars : [
		'seriesCalculator'
	],
	#category : #'ExercismWIP-Series'
}

{ #category : #config }
SeriesTest class >> uuid [
	"Answer a unique id for this exercise"
	^'c06ed5d9-2b3f-0d00-a2ad-e1a209f0590c'
]

{ #category : #config }
SeriesTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
SeriesTest >> setUp [
	seriesCalculator := Series new
]

{ #category : #test }
SeriesTest >> testEmptySeriesIsInvalid [
	| result |

	result := seriesCalculator slicesSliceLength: 1 series: '' .
	self assert: result equals: ((Dictionary new) add: ('error'->'series cannot be empty'); yourself)
]

{ #category : #test }
SeriesTest >> testSliceLengthCannotBeNegative [
	| result |

	result := seriesCalculator slicesSliceLength:  -1 series: '123' .
	self assert: result equals: ((Dictionary new) add: ('error'->'slice length cannot be negative'); yourself)
]

{ #category : #test }
SeriesTest >> testSliceLengthCannotBeZero [
	| result |

	result := seriesCalculator slicesSliceLength: 0 series: '12345' .
	self assert: result equals: ((Dictionary new) add: ('error'->'slice length cannot be zero'); yourself)
]

{ #category : #test }
SeriesTest >> testSliceLengthIsTooLarge [
	| result |

	result := seriesCalculator slicesSliceLength: 6 series: '12345' .
	self assert: result equals: ((Dictionary new) add: ('error'->'slice length cannot be greater than series length'); yourself)
]

{ #category : #test }
SeriesTest >> testSlicesCanIncludeDuplicates [
	| result |

	result := seriesCalculator slicesSliceLength: 3 series: '777777' .
	self assert: result equals: #('777' '777' '777' '777' )
]

{ #category : #test }
SeriesTest >> testSlicesOfALongSeries [
	| result |

	result := seriesCalculator slicesSliceLength: 5 series: '918493904243' .
	self assert: result equals: #('91849' '18493' '84939' '49390' '93904' '39042' '90424' '04243' )
]

{ #category : #test }
SeriesTest >> testSlicesOfOneFromOne [
	| result |

	result := seriesCalculator slicesSliceLength: 1 series: '1' .
	self assert: result equals: #('1' )
]

{ #category : #test }
SeriesTest >> testSlicesOfOneFromTwo [
	| result |

	result := seriesCalculator slicesSliceLength: 1 series: '12' .
	self assert: result equals: #('1' '2' )
]

{ #category : #test }
SeriesTest >> testSlicesOfTwo [
	| result |

	result := seriesCalculator slicesSliceLength: 2 series: '35' .
	self assert: result equals: #('35' )
]

{ #category : #test }
SeriesTest >> testSlicesOfTwoOverlap [
	| result |

	result := seriesCalculator slicesSliceLength: 2 series: '9142' .
	self assert: result equals: #('91' '14' '42' )
]
