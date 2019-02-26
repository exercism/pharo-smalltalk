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
	#name : #SayTest,
	#superclass : #ExercismTest,
	#instVars : [
		'sayCalculator'
	],
	#category : #'ExercismWIP-Say'
}

{ #category : #config }
SayTest class >> uuid [
	"Answer a unique id for this exercise"
	^'7937e5d9-2b3f-0d00-a2be-6dec09f0590c'
]

{ #category : #config }
SayTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
SayTest >> setUp [
	sayCalculator := Say new
]

{ #category : #test }
SayTest >> testABigNumber [
	| result |

	result := sayCalculator sayNumber: 987654321123 .
	self assert: result equals: 'nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three'
]

{ #category : #test }
SayTest >> testFourteen [
	| result |

	result := sayCalculator sayNumber: 14 .
	self assert: result equals: 'fourteen'
]

{ #category : #test }
SayTest >> testNumbersAbove999999999999AreOutOfRange [
	| result |

	result := sayCalculator sayNumber: 1000000000000 .
	self assert: result equals: ((Dictionary new) add: ('error'->'input out of range'); yourself)
]

{ #category : #test }
SayTest >> testNumbersBelowZeroAreOutOfRange [
	| result |

	result := sayCalculator sayNumber:  -1 .
	self assert: result equals: ((Dictionary new) add: ('error'->'input out of range'); yourself)
]

{ #category : #test }
SayTest >> testOne [
	| result |

	result := sayCalculator sayNumber: 1 .
	self assert: result equals: 'one'
]

{ #category : #test }
SayTest >> testOneBillion [
	| result |

	result := sayCalculator sayNumber: 1000000000 .
	self assert: result equals: 'one billion'
]

{ #category : #test }
SayTest >> testOneHundred [
	| result |

	result := sayCalculator sayNumber: 100 .
	self assert: result equals: 'one hundred'
]

{ #category : #test }
SayTest >> testOneHundredTwentythree [
	| result |

	result := sayCalculator sayNumber: 123 .
	self assert: result equals: 'one hundred twenty-three'
]

{ #category : #test }
SayTest >> testOneMillion [
	| result |

	result := sayCalculator sayNumber: 1000000 .
	self assert: result equals: 'one million'
]

{ #category : #test }
SayTest >> testOneMillionTwoThousandThreeHundredFortyfive [
	| result |

	result := sayCalculator sayNumber: 1002345 .
	self assert: result equals: 'one million two thousand three hundred forty-five'
]

{ #category : #test }
SayTest >> testOneThousand [
	| result |

	result := sayCalculator sayNumber: 1000 .
	self assert: result equals: 'one thousand'
]

{ #category : #test }
SayTest >> testOneThousandTwoHundredThirtyfour [
	| result |

	result := sayCalculator sayNumber: 1234 .
	self assert: result equals: 'one thousand two hundred thirty-four'
]

{ #category : #test }
SayTest >> testTwenty [
	| result |

	result := sayCalculator sayNumber: 20 .
	self assert: result equals: 'twenty'
]

{ #category : #test }
SayTest >> testTwentytwo [
	| result |

	result := sayCalculator sayNumber: 22 .
	self assert: result equals: 'twenty-two'
]

{ #category : #test }
SayTest >> testZero [
	| result |

	result := sayCalculator sayNumber: 0 .
	self assert: result equals: 'zero'
]
