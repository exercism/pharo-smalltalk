"
# Atbash Cipher

Create an implementation of the atbash cipher, an ancient encryption system created in the Middle East.

The Atbash cipher is a simple substitution cipher that relies on
transposing all the letters in the alphabet such that the resulting
alphabet is backwards. The first letter is replaced with the last
letter, the second with the second-last, and so on.

An Atbash cipher for the Latin alphabet would be as follows:

```text
Plain:  abcdefghijklmnopqrstuvwxyz
Cipher: zyxwvutsrqponmlkjihgfedcba
```

It is a very weak cipher because it only has one possible key, and it is
a simple monoalphabetic substitution cipher. However, this may not have
been an issue in the cipher's time.

Ciphertext is written out in groups of fixed length, the traditional group size
being 5 letters, and punctuation is excluded. This is to make it harder to guess
things based on word boundaries.

## Examples

- Encoding `test` gives `gvhg`
- Decoding `gvhg` gives `test`
- Decoding `gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt` gives `thequickbrownfoxjumpsoverthelazydog`

## Hint

TBD

"
Class {
	#name : #AtbashCipherTest,
	#superclass : #ExercismTest,
	#instVars : [
		'atbashCipherCalculator'
	],
	#category : #'ExercismWIP-AtbashCipher'
}

{ #category : #config }
AtbashCipherTest class >> uuid [
	"Answer a unique id for this exercise"
	^'75a6e8d9-2b3f-0d00-a2c1-5cfd09f0590c'
]

{ #category : #config }
AtbashCipherTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
AtbashCipherTest >> setUp [
	atbashCipherCalculator := AtbashCipher new
]

{ #category : #test }
AtbashCipherTest >> testDecodeDecodeASentence [
	| result |

	result := atbashCipherCalculator decodePhrase: 'zmlyh gzxov rhlug vmzhg vkkrm thglm v' .
	self assert: result equals: 'anobstacleisoftenasteppingstone'
]

{ #category : #test }
AtbashCipherTest >> testDecodeDecodeAllTheLetters [
	| result |

	result := atbashCipherCalculator decodePhrase: 'gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt' .
	self assert: result equals: 'thequickbrownfoxjumpsoverthelazydog'
]

{ #category : #test }
AtbashCipherTest >> testDecodeDecodeExercism [
	| result |

	result := atbashCipherCalculator decodePhrase: 'vcvix rhn' .
	self assert: result equals: 'exercism'
]

{ #category : #test }
AtbashCipherTest >> testDecodeDecodeNumbers [
	| result |

	result := atbashCipherCalculator decodePhrase: 'gvhgr mt123 gvhgr mt' .
	self assert: result equals: 'testing123testing'
]

{ #category : #test }
AtbashCipherTest >> testDecodeDecodeWithNoSpaces [
	| result |

	result := atbashCipherCalculator decodePhrase: 'zmlyhgzxovrhlugvmzhgvkkrmthglmv' .
	self assert: result equals: 'anobstacleisoftenasteppingstone'
]

{ #category : #test }
AtbashCipherTest >> testDecodeDecodeWithTooManySpaces [
	| result |

	result := atbashCipherCalculator decodePhrase: 'vc vix    r hn' .
	self assert: result equals: 'exercism'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeAllTheLetters [
	| result |

	result := atbashCipherCalculator encodePhrase: 'The quick brown fox jumps over the lazy dog.' .
	self assert: result equals: 'gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeDeepThought [
	| result |

	result := atbashCipherCalculator encodePhrase: 'Truth is fiction.' .
	self assert: result equals: 'gifgs rhurx grlm'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeMindblowingly [
	| result |

	result := atbashCipherCalculator encodePhrase: 'mindblowingly' .
	self assert: result equals: 'nrmwy oldrm tob'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeNo [
	| result |

	result := atbashCipherCalculator encodePhrase: 'no' .
	self assert: result equals: 'ml'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeNumbers [
	| result |

	result := atbashCipherCalculator encodePhrase: 'Testing,1 2 3, testing.' .
	self assert: result equals: 'gvhgr mt123 gvhgr mt'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeOMG [
	| result |

	result := atbashCipherCalculator encodePhrase: 'OMG' .
	self assert: result equals: 'lnt'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeSpaces [
	| result |

	result := atbashCipherCalculator encodePhrase: 'O M G' .
	self assert: result equals: 'lnt'
]

{ #category : #test }
AtbashCipherTest >> testEncodeEncodeYes [
	| result |

	result := atbashCipherCalculator encodePhrase: 'yes' .
	self assert: result equals: 'bvh'
]
