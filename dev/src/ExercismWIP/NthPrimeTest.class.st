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
	^'9097d12e-b043-0d00-9287-620802a76407'
]

{ #category : #config }
NthPrimeTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.1.0'
]

{ #category : #setup }
NthPrimeTest >> setUp [
	nthPrimeCalculator := NthPrime new
]

{ #category : #tests }
NthPrimeTest >> test01_FirstPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 1 .
	self assert: result equals: 2
]

{ #category : #tests }
NthPrimeTest >> test02_SecondPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 2 .
	self assert: result equals: 3
]

{ #category : #tests }
NthPrimeTest >> test03_SixthPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 6 .
	self assert: result equals: 13
]

{ #category : #tests }
NthPrimeTest >> test04_BigPrime [
	| result |

	result := nthPrimeCalculator primeNumber: 10001 .
	self assert: result equals: 104743
]

{ #category : #tests }
NthPrimeTest >> test05_ThereIsNoZerothPrime [
	| result |

	self
		should: [ result := nthPrimeCalculator primeNumber: 0 ]
		raise: Exception
		whoseDescriptionIncludes: 'there is no zeroth prime'
		description: 'Should get an error with the correct description'
]
