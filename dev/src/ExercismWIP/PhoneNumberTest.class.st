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
	^'83c1ac2e-b043-0d00-9253-3e3402a76407'
]

{ #category : #config }
PhoneNumberTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.7.0'
]

{ #category : #setup }
PhoneNumberTest >> setUp [
	phoneNumberCalculator := PhoneNumber new
]

{ #category : #tests }
PhoneNumberTest >> test01_CleansTheNumber [
	| result |

	result := phoneNumberCalculator cleanPhrase: '(223) 456-7890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test02_CleansNumbersWithDots [
	| result |

	result := phoneNumberCalculator cleanPhrase: '223.456.7890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test03_CleansNumbersWithMultipleSpaces [
	| result |

	result := phoneNumberCalculator cleanPhrase: '223 456   7890   ' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test04_InvalidWhen9Digits [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '123456789' ]
		raise: Exception
		whoseDescriptionIncludes: 'incorrect number of digits'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test05_InvalidWhen11DigitsDoesNotStartWithA1 [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '22234567890' ]
		raise: Exception
		whoseDescriptionIncludes: '11 digits must start with 1'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test06_ValidWhen11DigitsAndStartingWith1 [
	| result |

	result := phoneNumberCalculator cleanPhrase: '12234567890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test07_ValidWhen11DigitsAndStartingWith1EvenWithPunctuation [
	| result |

	result := phoneNumberCalculator cleanPhrase: '+1 (223) 456-7890' .
	self assert: result equals: '2234567890'
]

{ #category : #tests }
PhoneNumberTest >> test08_InvalidWhenMoreThan11Digits [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '321234567890' ]
		raise: Exception
		whoseDescriptionIncludes: 'more than 11 digits'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test09_InvalidWithLetters [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '123-abc-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'letters not permitted'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test10_InvalidWithPunctuations [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '123-@:!-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'punctuations not permitted'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test11_InvalidIfAreaCodeStartsWith0 [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '(023) 456-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'area code cannot start with zero'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test12_InvalidIfAreaCodeStartsWith1 [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '(123) 456-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'area code cannot start with one'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test13_InvalidIfExchangeCodeStartsWith0 [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '(223) 056-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'exchange code cannot start with zero'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test14_InvalidIfExchangeCodeStartsWith1 [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '(223) 156-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'exchange code cannot start with one'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test15_InvalidIfAreaCodeStartsWith0OnValid11digitNumber [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '1 (023) 456-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'area code cannot start with zero'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test16_InvalidIfAreaCodeStartsWith1OnValid11digitNumber [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '1 (123) 456-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'area code cannot start with one'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test17_InvalidIfExchangeCodeStartsWith0OnValid11digitNumber [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '1 (223) 056-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'exchange code cannot start with zero'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
PhoneNumberTest >> test18_InvalidIfExchangeCodeStartsWith1OnValid11digitNumber [
	| result |

	self
		should: [ result := phoneNumberCalculator cleanPhrase: '1 (223) 156-7890' ]
		raise: Exception
		whoseDescriptionIncludes: 'exchange code cannot start with one'
		description: 'Should get an error with the correct description'
]
