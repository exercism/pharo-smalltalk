"
# All Your Base

Convert a number, represented as a sequence of digits in one base, to any other base.

Implement general base conversion. Given a number in base **a**,
represented as a sequence of digits, convert it to base **b**.

## Note

- Try to implement the conversion yourself.
  Do not use something else to perform the conversion for you.

## About [Positional Notation](https://en.wikipedia.org/wiki/Positional_notation)

In positional notation, a number in base **b** can be understood as a linear
combination of powers of **b**.

The number 42, *in base 10*, means:

(4 * 10^1) + (2 * 10^0)

The number 101010, *in base 2*, means:

(1 * 2^5) + (0 * 2^4) + (1 * 2^3) + (0 * 2^2) + (1 * 2^1) + (0 * 2^0)

The number 1120, *in base 3*, means:

(1 * 3^3) + (1 * 3^2) + (2 * 3^1) + (0 * 3^0)

I think you got the idea!

*Yes. Those three numbers above are exactly the same. Congratulations!*

## Hint

TBD

"
Class {
	#name : #AllYourBaseTest,
	#superclass : #ExercismTest,
	#instVars : [
		'allYourBaseCalculator'
	],
	#category : #'ExercismWIP-AllYourBase'
}

{ #category : #config }
AllYourBaseTest class >> uuid [
	"Answer a unique id for this exercise"
	^'c3132fda-2b3f-0d00-a304-8a1109f0590c'
]

{ #category : #config }
AllYourBaseTest class >> version [
	"Generated from specification: 26 February 2019"
	^'2.3.0'
]

{ #category : #setup }
AllYourBaseTest >> setUp [
	allYourBaseCalculator := AllYourBase new
]

{ #category : #test }
AllYourBaseTest >> test15bitInteger [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 97 digits: #(3 46 60 ) outputBase: 73 .
	self assert: result equals: #(6 10 45 )
]

{ #category : #test }
AllYourBaseTest >> testBinaryToMultipleDecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 0 1 0 1 0 ) outputBase: 10 .
	self assert: result equals: #(4 2 )
]

{ #category : #test }
AllYourBaseTest >> testBinaryToSingleDecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 0 1 ) outputBase: 10 .
	self assert: result equals: #(5 )
]

{ #category : #test }
AllYourBaseTest >> testBothBasesAreNegative [
	| result |

	result := allYourBaseCalculator rebaseInputBase:  -2 digits: #(1 ) outputBase:  -7 .
	self assert: result equals: ((Dictionary new) add: ('error'->'input base must be >= 2'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testDecimalToBinary [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(4 2 ) outputBase: 2 .
	self assert: result equals: #(1 0 1 0 1 0 )
]

{ #category : #test }
AllYourBaseTest >> testEmptyList [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #() outputBase: 10 .
	self assert: result equals: #(0 )
]

{ #category : #test }
AllYourBaseTest >> testHexadecimalToTrinary [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 16 digits: #(2 10 ) outputBase: 3 .
	self assert: result equals: #(1 1 2 0 )
]

{ #category : #test }
AllYourBaseTest >> testInputBaseIsNegative [
	| result |

	result := allYourBaseCalculator rebaseInputBase:  -2 digits: #(1 ) outputBase: 10 .
	self assert: result equals: ((Dictionary new) add: ('error'->'input base must be >= 2'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testInputBaseIsOne [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 1 digits: #(0 ) outputBase: 10 .
	self assert: result equals: ((Dictionary new) add: ('error'->'input base must be >= 2'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testInputBaseIsZero [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 0 digits: #() outputBase: 10 .
	self assert: result equals: ((Dictionary new) add: ('error'->'input base must be >= 2'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testInvalidPositiveDigit [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 2 1 0 1 0 ) outputBase: 10 .
	self assert: result equals: ((Dictionary new) add: ('error'->'all digits must satisfy 0 <= d < input base'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testLeadingZeros [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 7 digits: #(0 6 0 ) outputBase: 10 .
	self assert: result equals: #(4 2 )
]

{ #category : #test }
AllYourBaseTest >> testMultipleZeros [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(0 0 0 ) outputBase: 2 .
	self assert: result equals: #(0 )
]

{ #category : #test }
AllYourBaseTest >> testNegativeDigit [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1  -1 1 0 1 0 ) outputBase: 10 .
	self assert: result equals: ((Dictionary new) add: ('error'->'all digits must satisfy 0 <= d < input base'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testOutputBaseIsNegative [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 ) outputBase:  -7 .
	self assert: result equals: ((Dictionary new) add: ('error'->'output base must be >= 2'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testOutputBaseIsOne [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 0 1 0 1 0 ) outputBase: 1 .
	self assert: result equals: ((Dictionary new) add: ('error'->'output base must be >= 2'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testOutputBaseIsZero [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(7 ) outputBase: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'output base must be >= 2'); yourself)
]

{ #category : #test }
AllYourBaseTest >> testSingleBitOneToDecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 ) outputBase: 10 .
	self assert: result equals: #(1 )
]

{ #category : #test }
AllYourBaseTest >> testSingleDecimalToBinary [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(5 ) outputBase: 2 .
	self assert: result equals: #(1 0 1 )
]

{ #category : #test }
AllYourBaseTest >> testSingleZero [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(0 ) outputBase: 2 .
	self assert: result equals: #(0 )
]

{ #category : #test }
AllYourBaseTest >> testTrinaryToHexadecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 3 digits: #(1 1 2 0 ) outputBase: 16 .
	self assert: result equals: #(2 10 )
]
