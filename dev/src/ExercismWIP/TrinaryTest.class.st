"
# Trinary

Convert a trinary number, represented as a string (e.g. '102012'), to its
decimal equivalent using first principles.

The program should consider strings specifying an invalid trinary as the
value 0.

Trinary numbers contain three symbols: 0, 1, and 2.

The last place in a trinary number is the 1's place. The second to last
is the 3's place, the third to last is the 9's place, etc.

```shell
# ""102012""
    1       0       2       0       1       2    # the number
1*3^5 + 0*3^4 + 2*3^3 + 0*3^2 + 1*3^1 + 2*3^0    # the value
  243 +     0 +    54 +     0 +     3 +     2 =  302
```

If your language provides a method in the standard library to perform the
conversion, pretend it doesn't exist and implement it yourself.

## Hint

TBD

"
Class {
	#name : #TrinaryTest,
	#superclass : #ExercismTest,
	#instVars : [
		'trinaryCalculator'
	],
	#category : #'ExercismWIP-Trinary'
}

{ #category : #config }
TrinaryTest class >> uuid [
	"Answer a unique id for this exercise"
	^'64c838be-4a3f-0d00-bb26-d815071d6982'
]

{ #category : #config }
TrinaryTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.1.0'
]

{ #category : #setup }
TrinaryTest >> setUp [
	trinaryCalculator := Trinary new
]

{ #category : #tests }
TrinaryTest >> test01_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary1IsDecimal1 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 1 .
	self assert: result equals: 1
]

{ #category : #tests }
TrinaryTest >> test02_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary2IsDecimal2 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 2 .
	self assert: result equals: 2
]

{ #category : #tests }
TrinaryTest >> test03_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary10IsDecimal3 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 10 .
	self assert: result equals: 3
]

{ #category : #tests }
TrinaryTest >> test04_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary11IsDecimal4 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 11 .
	self assert: result equals: 4
]

{ #category : #tests }
TrinaryTest >> test05_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary100IsDecimal9 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 100 .
	self assert: result equals: 9
]

{ #category : #tests }
TrinaryTest >> test06_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary112IsDecimal14 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 112 .
	self assert: result equals: 14
]

{ #category : #tests }
TrinaryTest >> test07_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary222IsDecimal26 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 222 .
	self assert: result equals: 26
]

{ #category : #tests }
TrinaryTest >> test08_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueTrinary1122000120IsDecimal32091 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 1122000120 .
	self assert: result equals: 32091
]

{ #category : #tests }
TrinaryTest >> test09_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueInvalidTrinaryDigitsReturns0 [
	| result |

	result := trinaryCalculator toDecimalTrinary: '1234' .
	self assert: result equals: 0
]

{ #category : #tests }
TrinaryTest >> test10_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueInvalidWordAsInputReturns0 [
	| result |

	result := trinaryCalculator toDecimalTrinary: 'carrot' .
	self assert: result equals: 0
]

{ #category : #tests }
TrinaryTest >> test11_ReturnsTheDecimalRepresentationOfTheInputTrinaryValueInvalidNumbersWithLettersAsInputReturns0 [
	| result |

	result := trinaryCalculator toDecimalTrinary: '0a1b2c' .
	self assert: result equals: 0
]
