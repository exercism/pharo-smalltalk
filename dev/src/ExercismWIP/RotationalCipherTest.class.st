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
	^'8fcda02e-b043-0d00-9244-594802a76407'
]

{ #category : #config }
RotationalCipherTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.2.0'
]

{ #category : #running }
RotationalCipherTest >> setUp [
	super setUp.
	rotationalCipherCalculator := RotationalCipher new
]

{ #category : #tests }
RotationalCipherTest >> test01_RotateABy0SameOutputAsInput [
	| result |

	result := rotationalCipherCalculator rotateText: 'a' shiftKey: 0 .
	self assert: result equals: 'a'
]

{ #category : #tests }
RotationalCipherTest >> test02_RotateABy1 [
	| result |

	result := rotationalCipherCalculator rotateText: 'a' shiftKey: 1 .
	self assert: result equals: 'b'
]

{ #category : #tests }
RotationalCipherTest >> test03_RotateABy26SameOutputAsInput [
	| result |

	result := rotationalCipherCalculator rotateText: 'a' shiftKey: 26 .
	self assert: result equals: 'a'
]

{ #category : #tests }
RotationalCipherTest >> test04_RotateMBy13 [
	| result |

	result := rotationalCipherCalculator rotateText: 'm' shiftKey: 13 .
	self assert: result equals: 'z'
]

{ #category : #tests }
RotationalCipherTest >> test05_RotateNBy13WithWrapAroundAlphabet [
	| result |

	result := rotationalCipherCalculator rotateText: 'n' shiftKey: 13 .
	self assert: result equals: 'a'
]

{ #category : #tests }
RotationalCipherTest >> test06_RotateCapitalLetters [
	| result |

	result := rotationalCipherCalculator rotateText: 'OMG' shiftKey: 5 .
	self assert: result equals: 'TRL'
]

{ #category : #tests }
RotationalCipherTest >> test07_RotateSpaces [
	| result |

	result := rotationalCipherCalculator rotateText: 'O M G' shiftKey: 5 .
	self assert: result equals: 'T R L'
]

{ #category : #tests }
RotationalCipherTest >> test08_RotateNumbers [
	| result |

	result := rotationalCipherCalculator rotateText: 'Testing 1 2 3 testing' shiftKey: 4 .
	self assert: result equals: 'Xiwxmrk 1 2 3 xiwxmrk'
]

{ #category : #tests }
RotationalCipherTest >> test09_RotatePunctuation [
	| result |

	result := rotationalCipherCalculator rotateText: 'Let''s eat, Grandma!' shiftKey: 21 .
	self assert: result equals: 'Gzo''n zvo, Bmviyhv!'
]

{ #category : #tests }
RotationalCipherTest >> test10_RotateAllLetters [
	| result |

	result := rotationalCipherCalculator rotateText: 'The quick brown fox jumps over the lazy dog.' shiftKey: 13 .
	self assert: result equals: 'Gur dhvpx oebja sbk whzcf bire gur ynml qbt.'
]
