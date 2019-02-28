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
	^'484c41be-4a3f-0d00-bb2b-aece071d6982'
]

{ #category : #config }
PhoneNumberTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.7.0'
]

{ #category : #setup }
PhoneNumberTest >> setUp [
	phoneNumberCalculator := PhoneNumber new
]

{ #category : #tests }
PhoneNumberTest >> test01_CleanupUserenteredPhoneNumbersCleansTheNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(223) 456-7890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test02_CleanupUserenteredPhoneNumbersCleansNumbersWithDots [
	| result |

	result := phoneNumberCalculator cleanPhrase: '223.456.7890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test03_CleanupUserenteredPhoneNumbersCleansNumbersWithMultipleSpaces [
	| result |

	result := phoneNumberCalculator cleanPhrase: '223 456   7890   ' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test04_CleanupUserenteredPhoneNumbersInvalidWhen9Digits [
	| result |

	result := phoneNumberCalculator cleanPhrase: '123456789' .
	self assert: result equals: ((Dictionary new) add: ('error'->'incorrect number of digits'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test05_CleanupUserenteredPhoneNumbersInvalidWhen11DigitsDoesNotStartWithA1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '22234567890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'11 digits must start with 1'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test06_CleanupUserenteredPhoneNumbersValidWhen11DigitsAndStartingWith1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '12234567890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test07_CleanupUserenteredPhoneNumbersValidWhen11DigitsAndStartingWith1EvenWithPunctuation [
	| result |

	result := phoneNumberCalculator cleanPhrase: '+1 (223) 456-7890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test08_CleanupUserenteredPhoneNumbersInvalidWhenMoreThan11Digits [
	| result |

	result := phoneNumberCalculator cleanPhrase: '321234567890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'more than 11 digits'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test09_CleanupUserenteredPhoneNumbersInvalidWithLetters [
	| result |

	result := phoneNumberCalculator cleanPhrase: '123-abc-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'letters not permitted'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test10_CleanupUserenteredPhoneNumbersInvalidWithPunctuations [
	| result |

	result := phoneNumberCalculator cleanPhrase: '123-@:!-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'punctuations not permitted'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test11_CleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith0 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(023) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with zero'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test12_CleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(123) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with one'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test13_CleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith0 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(223) 056-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with zero'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test14_CleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(223) 156-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with one'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test15_CleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith0OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (023) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with zero'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test16_CleanupUserenteredPhoneNumbersInvalidIfAreaCodeStartsWith1OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (123) 456-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'area code cannot start with one'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test17_CleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith0OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (223) 056-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with zero'); yourself)
]

{ #category : #tests }
PhoneNumberTest >> test18_CleanupUserenteredPhoneNumbersInvalidIfExchangeCodeStartsWith1OnValid11digitNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '1 (223) 156-7890' .
	self assert: result equals: ((Dictionary new) add: ('error'->'exchange code cannot start with one'); yourself)
]
