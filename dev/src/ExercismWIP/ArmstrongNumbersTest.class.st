"
# Armstrong Numbers

An [Armstrong number](https://en.wikipedia.org/wiki/Narcissistic_number) is a number that is the sum of its own digits each raised to the power of the number of digits.

For example:

- 9 is an Armstrong number, because `9 = 9^1 = 9`
- 10 is *not* an Armstrong number, because `10 != 1^2 + 0^2 = 1`
- 153 is an Armstrong number, because: `153 = 1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153`
- 154 is *not* an Armstrong number, because: `154 != 1^3 + 5^3 + 4^3 = 1 + 125 + 64 = 190`

Write some code to determine whether a number is an Armstrong number.

## Hint

TBD

"
Class {
	#name : #ArmstrongNumbersTest,
	#superclass : #ExercismTest,
	#instVars : [
		'armstrongNumbersCalculator'
	],
	#category : #'ExercismWIP-ArmstrongNumbers'
}

{ #category : #config }
ArmstrongNumbersTest class >> uuid [
	"Answer a unique id for this exercise"
	^'b78eded9-2b3f-0d00-a2b6-35a509f0590c'
]

{ #category : #config }
ArmstrongNumbersTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
ArmstrongNumbersTest >> setUp [
	armstrongNumbersCalculator := ArmstrongNumbers new
]

{ #category : #test }
ArmstrongNumbersTest >> testFourDigitNumberThatIsAnArmstrongNumber [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 9474 .
	self assert: result equals: true
]

{ #category : #test }
ArmstrongNumbersTest >> testFourDigitNumberThatIsNotAnArmstrongNumber [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 9475 .
	self assert: result equals: false
]

{ #category : #test }
ArmstrongNumbersTest >> testSevenDigitNumberThatIsAnArmstrongNumber [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 9926315 .
	self assert: result equals: true
]

{ #category : #test }
ArmstrongNumbersTest >> testSevenDigitNumberThatIsNotAnArmstrongNumber [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 9926314 .
	self assert: result equals: false
]

{ #category : #test }
ArmstrongNumbersTest >> testSingleDigitNumbersAreArmstrongNumbers [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 5 .
	self assert: result equals: true
]

{ #category : #test }
ArmstrongNumbersTest >> testThereAreNo2DigitArmstrongNumbers [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 10 .
	self assert: result equals: false
]

{ #category : #test }
ArmstrongNumbersTest >> testThreeDigitNumberThatIsAnArmstrongNumber [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 153 .
	self assert: result equals: true
]

{ #category : #test }
ArmstrongNumbersTest >> testThreeDigitNumberThatIsNotAnArmstrongNumber [
	| result |

	result := armstrongNumbersCalculator isArmstrongNumber: 100 .
	self assert: result equals: false
]
