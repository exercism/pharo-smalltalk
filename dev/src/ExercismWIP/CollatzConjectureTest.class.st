"
# Collatz Conjecture

The Collatz Conjecture or 3x+1 problem can be summarized as follows:

Take any positive integer n. If n is even, divide n by 2 to get n / 2. If n is
odd, multiply n by 3 and add 1 to get 3n + 1. Repeat the process indefinitely.
The conjecture states that no matter which number you start with, you will
always reach 1 eventually.

Given a number n, return the number of steps required to reach 1.

## Examples

Starting with n = 12, the steps would be as follows:

0. 12
1. 6
2. 3
3. 10
4. 5
5. 16
6. 8
7. 4
8. 2
9. 1

Resulting in 9 steps. So for input n = 12, the return value would be 9.

## Hint

TBD

"
Class {
	#name : #CollatzConjectureTest,
	#superclass : #ExercismTest,
	#instVars : [
		'collatzConjectureCalculator'
	],
	#category : #'ExercismWIP-CollatzConjecture'
}

{ #category : #config }
CollatzConjectureTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d0fe32da-2b3f-0d00-a308-55f509f0590c'
]

{ #category : #config }
CollatzConjectureTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.1'
]

{ #category : #setup }
CollatzConjectureTest >> setUp [
	collatzConjectureCalculator := CollatzConjecture new
]

{ #category : #test }
CollatzConjectureTest >> testDivideIfEven [
	| result |

	result := collatzConjectureCalculator stepsNumber: 16 .
	self assert: result equals: 4
]

{ #category : #test }
CollatzConjectureTest >> testEvenAndOddSteps [
	| result |

	result := collatzConjectureCalculator stepsNumber: 12 .
	self assert: result equals: 9
]

{ #category : #test }
CollatzConjectureTest >> testLargeNumberOfEvenAndOddSteps [
	| result |

	result := collatzConjectureCalculator stepsNumber: 1000000 .
	self assert: result equals: 152
]

{ #category : #test }
CollatzConjectureTest >> testNegativeValueIsAnError [
	| result |

	result := collatzConjectureCalculator stepsNumber:  -15 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Only positive numbers are allowed'); yourself)
]

{ #category : #test }
CollatzConjectureTest >> testZeroIsAnError [
	| result |

	result := collatzConjectureCalculator stepsNumber: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Only positive numbers are allowed'); yourself)
]

{ #category : #test }
CollatzConjectureTest >> testZeroStepsForOne [
	| result |

	result := collatzConjectureCalculator stepsNumber: 1 .
	self assert: result equals: 0
]
