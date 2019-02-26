"
# Secret Handshake

> There are 10 types of people in the world: Those who understand
> binary, and those who don't.

You and your fellow cohort of those in the ""know"" when it comes to
binary decide to come up with a secret ""handshake"".

```text
1 = wink
10 = double blink
100 = close your eyes
1000 = jump


10000 = Reverse the order of the operations in the secret handshake.
```

Given a decimal number, convert it to the appropriate sequence of events for a secret handshake.

Here's a couple of examples:

Given the input 3, the function would return the array
[""wink"", ""double blink""] because 3 is 11 in binary.

Given the input 19, the function would return the array
[""double blink"", ""wink""] because 19 is 10011 in binary.
Notice that the addition of 16 (10000 in binary)
has caused the array to be reversed.

## Hint

TBD

"
Class {
	#name : #SecretHandshakeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'secretHandshakeCalculator'
	],
	#category : #'ExercismWIP-SecretHandshake'
}

{ #category : #config }
SecretHandshakeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'8782e2d9-2b3f-0d00-a2bb-aa8a09f0590c'
]

{ #category : #config }
SecretHandshakeTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
SecretHandshakeTest >> setUp [
	secretHandshakeCalculator := SecretHandshake new
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberAllPossibleActions [
	| result |

	result := secretHandshakeCalculator commandsNumber: 15 .
	self assert: result equals: #('wink' 'double blink' 'close your eyes' 'jump' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberCloseYourEyesFor100 [
	| result |

	result := secretHandshakeCalculator commandsNumber: 4 .
	self assert: result equals: #('close your eyes' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberCombineTwoActions [
	| result |

	result := secretHandshakeCalculator commandsNumber: 3 .
	self assert: result equals: #('wink' 'double blink' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberDoNothingForZero [
	| result |

	result := secretHandshakeCalculator commandsNumber: 0 .
	self assert: result equals: #()
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberDoubleBlinkFor10 [
	| result |

	result := secretHandshakeCalculator commandsNumber: 2 .
	self assert: result equals: #('double blink' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberJumpFor1000 [
	| result |

	result := secretHandshakeCalculator commandsNumber: 8 .
	self assert: result equals: #('jump' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberReverseAllPossibleActions [
	| result |

	result := secretHandshakeCalculator commandsNumber: 31 .
	self assert: result equals: #('jump' 'close your eyes' 'double blink' 'wink' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberReverseTwoActions [
	| result |

	result := secretHandshakeCalculator commandsNumber: 19 .
	self assert: result equals: #('double blink' 'wink' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberReversingNoActionsStillGivesNoActions [
	| result |

	result := secretHandshakeCalculator commandsNumber: 16 .
	self assert: result equals: #()
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberReversingOneActionGivesTheSameAction [
	| result |

	result := secretHandshakeCalculator commandsNumber: 24 .
	self assert: result equals: #('jump' )
]

{ #category : #test }
SecretHandshakeTest >> testCreateAHandshakeForANumberWinkFor1 [
	| result |

	result := secretHandshakeCalculator commandsNumber: 1 .
	self assert: result equals: #('wink' )
]
