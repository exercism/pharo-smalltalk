"
# Phone Number

Clean up user-entered phone numbers so that they can be sent SMS messages.

The **North American Numbering Plan (NANP)** is a telephone numbering system used by many countries in North America like the United States, Canada or Bermuda. All NANP-countries share the same international country code: `1`.

NANP numbers are ten-digit numbers consisting of a three-digit Numbering Plan Area code, commonly known as *area code*, followed by a seven-digit local number. The first three digits of the local number represent the *exchange code*, followed by the unique four-digit number which is the *subscriber number*.

The format is usually represented as

```text
(NXX)-NXX-XXXX
```

where `N` is any digit from 2 through 9 and `X` is any digit from 0 through 9.

Your task is to clean up differently formatted telephone numbers by removing punctuation and the country code (1) if present.

For example, the inputs
- `+1 (613)-995-0253`
- `613-995-0253`
- `1 613 995 0253`
- `613.995.0253`

should all produce the output

`6139950253`

**Note:** As this exercise only deals with telephone numbers used in NANP-countries, only 1 is considered a valid country code.

## Hint

TBD

"
Class {
	#name : #PhoneNumberTest,
	#superclass : #ExercismTest,
	#instVars : [
		'phoneNumberCalculator'
	],
	#category : #'ExercismWIP-PhoneNumber'
}

{ #category : #config }
PhoneNumberTest class >> uuid [
	"Answer a unique id for this exercise"
	^'e5f5eed9-2b3f-0d00-a2c7-d99709f0590c'
]

{ #category : #config }
PhoneNumberTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.7.0'
]

{ #category : #setup }
PhoneNumberTest >> setUp [
	phoneNumberCalculator := PhoneNumber new
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersCleansNumbersWithDots [
	| result |

	result := phoneNumberCalculator cleanPhrase: '223.456.7890' .
	self assert: result equals: '2234567890'
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersCleansNumbersWithMultipleSpaces [
	| result |

	result := phoneNumberCalculator cleanPhrase: '223 456   7890   ' .
	self assert: result equals: '2234567890'
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersCleansTheNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(223) 456-7890' .
	self assert: result equals: '2234567890'
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith0 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(023) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with zero'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith0OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (023) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with zero'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(123) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with one'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith1OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (123) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with one'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith0 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(223) 056-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with zero'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith0OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (223) 056-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with zero'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(223) 156-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with one'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith1OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (223) 156-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with one'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidWhen11DigitsDoesNotStartWithA1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '22234567890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'11 digits must start with 1'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidWhen9Digits [
	| result |

	result := phoneNumberCalculator cleanPhrase: '123456789' .
	self assert: result equals: ((Dictionary new) add: ('error'->'incorrect number of digits'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidWhenMoreThan11Digits [
	| result |

	result := phoneNumberCalculator cleanPhrase: '321234567890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'more than 11 digits'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidWithLetters [
	| result |

	result := phoneNumberCalculator cleanPhrase: '123-abc-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'letters not permitted'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersInvalidWithPunctuations [
	| result |

	result := phoneNumberCalculator cleanPhrase: '123-@:!-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'punctuations not permitted'); yourself)
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersValidWhen11DigitsAndStartingWith1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '12234567890' .
	self assert: result equals: '2234567890'
]

{ #category : #test }
PhoneNumberTest >> testCleanupUserenteredPhoneNumbersValidWhen11DigitsAndStartingWith1EvenWithPunctuation [
	| result |

	result := phoneNumberCalculator cleanPhrase: '+1 (223) 456-7890' .
	self assert: result equals: '2234567890'
]
