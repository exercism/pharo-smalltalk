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
	^'a55e0117-9d41-0d00-900e-5c5a08866539'
]

{ #category : #config }
CollatzConjectureTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.2.1'
]

{ #category : #setup }
CollatzConjectureTest >> setUp [
	collatzConjectureCalculator := CollatzConjecture new
]

{ #category : #tests }
CollatzConjectureTest >> test01_ZeroStepsForOne [
	| result |

	result := collatzConjectureCalculator stepsNumber: 1 .
	self assert: result equals: 0
]

{ #category : #tests }
CollatzConjectureTest >> test02_DivideIfEven [
	| result |

	result := collatzConjectureCalculator stepsNumber: 16 .
	self assert: result equals: 4
]

{ #category : #tests }
CollatzConjectureTest >> test03_EvenAndOddSteps [
	| result |

	result := collatzConjectureCalculator stepsNumber: 12 .
	self assert: result equals: 9
]

{ #category : #tests }
CollatzConjectureTest >> test04_LargeNumberOfEvenAndOddSteps [
	| result |

	result := collatzConjectureCalculator stepsNumber: 1000000 .
	self assert: result equals: 152
]

{ #category : #tests }
CollatzConjectureTest >> test05_ZeroIsAnError [
	| result |

	result := collatzConjectureCalculator stepsNumber: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Only positive numbers are allowed'); yourself)
]

{ #category : #tests }
CollatzConjectureTest >> test06_NegativeValueIsAnError [
	| result |

	result := collatzConjectureCalculator stepsNumber:  -15 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Only positive numbers are allowed'); yourself)
]
