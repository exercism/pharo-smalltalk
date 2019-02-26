"
# Rotational Cipher

Create an implementation of the rotational cipher, also sometimes called the Caesar cipher.

The Caesar cipher is a simple shift cipher that relies on
transposing all the letters in the alphabet using an integer key
between `0` and `26`. Using a key of `0` or `26` will always yield
the same output due to modular arithmetic. The letter is shifted
for as many values as the value of the key.

The general notation for rotational ciphers is `ROT + <key>`.
The most commonly used rotational cipher is `ROT13`.

A `ROT13` on the Latin alphabet would be as follows:

```text
Plain:  abcdefghijklmnopqrstuvwxyz
Cipher: nopqrstuvwxyzabcdefghijklm
```

It is stronger than the Atbash cipher because it has 27 possible keys, and 25 usable keys.

Ciphertext is written out in the same formatting as the input including spaces and punctuation.

## Examples

- ROT5  `omg` gives `trl`
- ROT0  `c` gives `c`
- ROT26 `Cool` gives `Cool`
- ROT13 `The quick brown fox jumps over the lazy dog.` gives `Gur dhvpx oebja sbk whzcf bire gur ynml qbt.`
- ROT13 `Gur dhvpx oebja sbk whzcf bire gur ynml qbt.` gives `The quick brown fox jumps over the lazy dog.`

## Hint

TBD

"
Class {
	#name : #RotationalCipherTest,
	#superclass : #ExercismTest,
	#instVars : [
		'rotationalCipherCalculator'
	],
	#category : #'ExercismWIP-RotationalCipher'
}

{ #category : #config }
RotationalCipherTest class >> uuid [
	"Answer a unique id for this exercise"
	^'bf82d9d9-2b3f-0d00-a2b1-e20e09f0590c'
]

{ #category : #config }
RotationalCipherTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
RotationalCipherTest >> setUp [
	rotationalCipherCalculator := RotationalCipher new
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateABy0SameOutputAsInput [
	| result |

	result := rotationalCipherCalculator rotateText: 'a' shiftKey: 0 .
	self assert: result equals: 'a'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateABy1 [
	| result |

	result := rotationalCipherCalculator rotateText: 'a' shiftKey: 1 .
	self assert: result equals: 'b'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateABy26SameOutputAsInput [
	| result |

	result := rotationalCipherCalculator rotateText: 'a' shiftKey: 26 .
	self assert: result equals: 'a'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateAllLetters [
	| result |

	result := rotationalCipherCalculator rotateText: 'The quick brown fox jumps over the lazy dog.' shiftKey: 13 .
	self assert: result equals: 'Gur dhvpx oebja sbk whzcf bire gur ynml qbt.'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateCapitalLetters [
	| result |

	result := rotationalCipherCalculator rotateText: 'OMG' shiftKey: 5 .
	self assert: result equals: 'TRL'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateMBy13 [
	| result |

	result := rotationalCipherCalculator rotateText: 'm' shiftKey: 13 .
	self assert: result equals: 'z'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateNBy13WithWrapAroundAlphabet [
	| result |

	result := rotationalCipherCalculator rotateText: 'n' shiftKey: 13 .
	self assert: result equals: 'a'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateNumbers [
	| result |

	result := rotationalCipherCalculator rotateText: 'Testing 1 2 3 testing' shiftKey: 4 .
	self assert: result equals: 'Xiwxmrk 1 2 3 xiwxmrk'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotatePunctuation [
	| result |

	result := rotationalCipherCalculator rotateText: 'Let''s eat, Grandma!' shiftKey: 21 .
	self assert: result equals: 'Gzo''n zvo, Bmviyhv!'
]

{ #category : #test }
RotationalCipherTest >> testTestRotationFromEnglishToROTnRotateSpaces [
	| result |

	result := rotationalCipherCalculator rotateText: 'O M G' shiftKey: 5 .
	self assert: result equals: 'T R L'
]
