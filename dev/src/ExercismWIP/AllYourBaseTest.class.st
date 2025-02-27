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
	#name : 'AllYourBaseTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'allYourBaseCalculator'
	],
	#category : 'ExercismWIP-AllYourBase',
	#package : 'ExercismWIP',
	#tag : 'AllYourBase'
}

{ #category : 'config' }
AllYourBaseTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d5e9cc2e-b043-0d00-9280-13b302a76407'
]

{ #category : 'config' }
AllYourBaseTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.3.0'
]

{ #category : 'running' }
AllYourBaseTest >> setUp [
	super setUp.
	allYourBaseCalculator := AllYourBase new
]

{ #category : 'tests' }
AllYourBaseTest >> test01_SingleBitOneToDecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 ) outputBase: 10 .
	self assert: result equals: #(1 )
]

{ #category : 'tests' }
AllYourBaseTest >> test02_BinaryToSingleDecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 0 1 ) outputBase: 10 .
	self assert: result equals: #(5 )
]

{ #category : 'tests' }
AllYourBaseTest >> test03_SingleDecimalToBinary [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(5 ) outputBase: 2 .
	self assert: result equals: #(1 0 1 )
]

{ #category : 'tests' }
AllYourBaseTest >> test04_BinaryToMultipleDecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 0 1 0 1 0 ) outputBase: 10 .
	self assert: result equals: #(4 2 )
]

{ #category : 'tests' }
AllYourBaseTest >> test05_DecimalToBinary [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(4 2 ) outputBase: 2 .
	self assert: result equals: #(1 0 1 0 1 0 )
]

{ #category : 'tests' }
AllYourBaseTest >> test06_TrinaryToHexadecimal [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 3 digits: #(1 1 2 0 ) outputBase: 16 .
	self assert: result equals: #(2 10 )
]

{ #category : 'tests' }
AllYourBaseTest >> test07_HexadecimalToTrinary [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 16 digits: #(2 10 ) outputBase: 3 .
	self assert: result equals: #(1 1 2 0 )
]

{ #category : 'tests' }
AllYourBaseTest >> test08_15bitInteger [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 97 digits: #(3 46 60 ) outputBase: 73 .
	self assert: result equals: #(6 10 45 )
]

{ #category : 'tests' }
AllYourBaseTest >> test09_EmptyList [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 2 digits: #() outputBase: 10 .
	self assert: result equals: #(0 )
]

{ #category : 'tests' }
AllYourBaseTest >> test10_SingleZero [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(0 ) outputBase: 2 .
	self assert: result equals: #(0 )
]

{ #category : 'tests' }
AllYourBaseTest >> test11_MultipleZeros [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 10 digits: #(0 0 0 ) outputBase: 2 .
	self assert: result equals: #(0 )
]

{ #category : 'tests' }
AllYourBaseTest >> test12_LeadingZeros [
	| result |

	result := allYourBaseCalculator rebaseInputBase: 7 digits: #(0 6 0 ) outputBase: 10 .
	self assert: result equals: #(4 2 )
]

{ #category : 'tests' }
AllYourBaseTest >> test13_InputBaseIsOne [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase: 1 digits: #(0 ) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test14_InputBaseIsZero [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase: 0 digits: #() outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test15_InputBaseIsNegative [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase:  -2 digits: #(1 ) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test16_NegativeDigit [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1  -1 1 0 1 0 ) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'all digits must satisfy 0 <= d < input base'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test17_InvalidPositiveDigit [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 2 1 0 1 0 ) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'all digits must satisfy 0 <= d < input base'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test18_OutputBaseIsOne [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 0 1 0 1 0 ) outputBase: 1 ]
		raise: Error
		whoseDescriptionIncludes: 'output base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test19_OutputBaseIsZero [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase: 10 digits: #(7 ) outputBase: 0 ]
		raise: Error
		whoseDescriptionIncludes: 'output base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test20_OutputBaseIsNegative [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase: 2 digits: #(1 ) outputBase:  -7 ]
		raise: Error
		whoseDescriptionIncludes: 'output base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test21_BothBasesAreNegative [
	| result |

	self
		should: [ result := allYourBaseCalculator rebaseInputBase:  -2 digits: #(1 ) outputBase:  -7 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]
