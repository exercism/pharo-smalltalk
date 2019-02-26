"
# Nth Prime

Given a number n, determine what the nth prime is.

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that
the 6th prime is 13.

If your language provides methods in the standard library to deal with prime
numbers, pretend they don't exist and implement them yourself.

## Hint

TBD

"
Class {
	#name : #NthPrimeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'nthPrimeCalculator'
	],
	#category : #'ExercismWIP-NthPrime'
}

{ #category : #config }
NthPrimeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'e61e3ada-2b3f-0d00-a30e-f5c109f0590c'
]

{ #category : #config }
NthPrimeTest class >> version [
	"Generated from specification: 26 February 2019"
	^'2.1.0'
]

{ #category : #setup }
NthPrimeTest >> setUp [
	nthPrimeCalculator := NthPrime new
]

{ #category : #test }
NthPrimeTest >> testBigPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 10001 .
	self assert: result equals: 104743
]

{ #category : #test }
NthPrimeTest >> testFirstPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 1 .
	self assert: result equals: 2
]

{ #category : #test }
NthPrimeTest >> testSecondPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 2 .
	self assert: result equals: 3
]

{ #category : #test }
NthPrimeTest >> testSixthPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 6 .
	self assert: result equals: 13
]

{ #category : #test }
NthPrimeTest >> testThereIsNoZerothPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'there is no zeroth prime'); yourself)
]
