"
# Say

Given a number from 0 to 999,999,999,999, spell out that number in English.

## Step 1

Handle the basic case of 0 through 99.

If the input to the program is `22`, then the output should be
`'twenty-two'`.

Your program should complain loudly if given a number outside the
blessed range.

Some good test cases for this program are:

- 0
- 14
- 50
- 98
- -1
- 100

### Extension

If you're on a Mac, shell out to Mac OS X's `say` program to talk out
loud. If you're on Linux or Windows, eSpeakNG may be available with the command `espeak`.

## Step 2

Implement breaking a number up into chunks of thousands.

So `1234567890` should yield a list like 1, 234, 567, and 890, while the
far simpler `1000` should yield just 1 and 0.

The program must also report any values that are out of range.

## Step 3

Now handle inserting the appropriate scale word between those chunks.

So `1234567890` should yield `'1 billion 234 million 567 thousand 890'`

The program must also report any values that are out of range.  It's
fine to stop at ""trillion"".

## Step 4

Put it all together to get nothing but plain English.

`12345` should give `twelve thousand three hundred forty-five`.

The program must also report any values that are out of range.

### Extensions

Use _and_ (correctly) when spelling out the number in English:

- 14 becomes ""fourteen"".
- 100 becomes ""one hundred"".
- 120 becomes ""one hundred and twenty"".
- 1002 becomes ""one thousand and two"".
- 1323 becomes ""one thousand three hundred and twenty-three"".

## Hint

TBD

"
Class {
	#name : 'SayTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'sayCalculator'
	],
	#category : 'ExercismWIP-Say',
	#package : 'ExercismWIP',
	#tag : 'Say'
}

{ #category : 'config' }
SayTest class >> uuid [
	"Answer a unique id for this exercise"
	^'b12ca82e-b043-0d00-924e-65ac02a76407'
]

{ #category : 'config' }
SayTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.2.0'
]

{ #category : 'running' }
SayTest >> setUp [
	super setUp.
	sayCalculator := Say new
]

{ #category : 'tests' }
SayTest >> test01_Zero [
	| result |

	result := sayCalculator sayNumber: 0 .
	self assert: result equals: 'zero'
]

{ #category : 'tests' }
SayTest >> test02_One [
	| result |

	result := sayCalculator sayNumber: 1 .
	self assert: result equals: 'one'
]

{ #category : 'tests' }
SayTest >> test03_Fourteen [
	| result |

	result := sayCalculator sayNumber: 14 .
	self assert: result equals: 'fourteen'
]

{ #category : 'tests' }
SayTest >> test04_Twenty [
	| result |

	result := sayCalculator sayNumber: 20 .
	self assert: result equals: 'twenty'
]

{ #category : 'tests' }
SayTest >> test05_Twentytwo [
	| result |

	result := sayCalculator sayNumber: 22 .
	self assert: result equals: 'twenty-two'
]

{ #category : 'tests' }
SayTest >> test06_OneHundred [
	| result |

	result := sayCalculator sayNumber: 100 .
	self assert: result equals: 'one hundred'
]

{ #category : 'tests' }
SayTest >> test07_OneHundredTwentythree [
	| result |

	result := sayCalculator sayNumber: 123 .
	self assert: result equals: 'one hundred twenty-three'
]

{ #category : 'tests' }
SayTest >> test08_OneThousand [
	| result |

	result := sayCalculator sayNumber: 1000 .
	self assert: result equals: 'one thousand'
]

{ #category : 'tests' }
SayTest >> test09_OneThousandTwoHundredThirtyfour [
	| result |

	result := sayCalculator sayNumber: 1234 .
	self assert: result equals: 'one thousand two hundred thirty-four'
]

{ #category : 'tests' }
SayTest >> test10_OneMillion [
	| result |

	result := sayCalculator sayNumber: 1000000 .
	self assert: result equals: 'one million'
]

{ #category : 'tests' }
SayTest >> test11_OneMillionTwoThousandThreeHundredFortyfive [
	| result |

	result := sayCalculator sayNumber: 1002345 .
	self assert: result equals: 'one million two thousand three hundred forty-five'
]

{ #category : 'tests' }
SayTest >> test12_OneBillion [
	| result |

	result := sayCalculator sayNumber: 1000000000 .
	self assert: result equals: 'one billion'
]

{ #category : 'tests' }
SayTest >> test13_ABigNumber [
	| result |

	result := sayCalculator sayNumber: 987654321123 .
	self assert: result equals: 'nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three'
]

{ #category : 'tests' }
SayTest >> test14_NumbersBelowZeroAreOutOfRange [
	| result |

	self
		should: [ result := sayCalculator sayNumber:  -1 ]
		raise: Error
		whoseDescriptionIncludes: 'input out of range'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
SayTest >> test15_NumbersAbove999999999999AreOutOfRange [
	| result |

	self
		should: [ result := sayCalculator sayNumber: 1000000000000 ]
		raise: Error
		whoseDescriptionIncludes: 'input out of range'
		description: 'Should get an error with the correct description'
]
