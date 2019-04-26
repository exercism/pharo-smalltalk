"
# Gigasecond

Given a moment, determine the moment that would be after a gigasecond
has passed.

A gigasecond is 10^9 (1,000,000,000) seconds.

## Hint

TBD

"
Class {
	#name : #GigasecondTest,
	#superclass : #ExercismTest,
	#instVars : [
		'gigasecondCalculator'
	],
	#category : #'ExercismWIP-Gigasecond'
}

{ #category : #config }
GigasecondTest class >> uuid [
	"Answer a unique id for this exercise"
	^'a225b12e-b043-0d00-925b-cdc102a76407'
]

{ #category : #config }
GigasecondTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.0.0'
]

{ #category : #setup }
GigasecondTest >> setUp [
	gigasecondCalculator := Gigasecond new
]

{ #category : #tests }
GigasecondTest >> test01_DateOnlySpecificationOfTime [
	| result |

	result := gigasecondCalculator addMoment: '2011-04-25' .
	self assert: result equals: '2043-01-01T01:46:40'
]

{ #category : #tests }
GigasecondTest >> test02_SecondTestForDateOnlySpecificationOfTime [
	| result |

	result := gigasecondCalculator addMoment: '1977-06-13' .
	self assert: result equals: '2009-02-19T01:46:40'
]

{ #category : #tests }
GigasecondTest >> test03_ThirdTestForDateOnlySpecificationOfTime [
	| result |

	result := gigasecondCalculator addMoment: '1959-07-19' .
	self assert: result equals: '1991-03-27T01:46:40'
]

{ #category : #tests }
GigasecondTest >> test04_FullTimeSpecified [
	| result |

	result := gigasecondCalculator addMoment: '2015-01-24T22:00:00' .
	self assert: result equals: '2046-10-02T23:46:40'
]

{ #category : #tests }
GigasecondTest >> test05_FullTimeWithDayRollover [
	| result |

	result := gigasecondCalculator addMoment: '2015-01-24T23:59:59' .
	self assert: result equals: '2046-10-03T01:46:39'
]
