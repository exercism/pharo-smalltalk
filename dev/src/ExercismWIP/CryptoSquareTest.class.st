"
# Crypto Square

Implement the classic method for composing secret messages called a square code.

Given an English text, output the encoded version of that text.

First, the input is normalized: the spaces and punctuation are removed
from the English text and the message is downcased.

Then, the normalized characters are broken into rows.  These rows can be
regarded as forming a rectangle when printed with intervening newlines.

For example, the sentence

```text
""If man was meant to stay on the ground, god would have given us roots.""
```

is normalized to:

```text
""ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots""
```

The plaintext should be organized in to a rectangle.  The size of the
rectangle (`r x c`) should be decided by the length of the message,
such that `c >= r` and `c - r <= 1`, where `c` is the number of columns
and `r` is the number of rows.

Our normalized text is 54 characters long, dictating a rectangle with
`c = 8` and `r = 7`:

```text
""ifmanwas""
""meanttos""
""tayonthe""
""groundgo""
""dwouldha""
""vegivenu""
""sroots  ""
```

The coded message is obtained by reading down the columns going left to
right.

The message above is coded as:

```text
""imtgdvsfearwermayoogoanouuiontnnlvtwttddesaohghnsseoau""
```

Output the encoded text in chunks that fill perfect rectangles `(r X c)`,
with `c` chunks of `r` length, separated by spaces. For phrases that are
`n` characters short of the perfect rectangle, pad each of the last `n`
chunks with a single trailing space.

```text
""imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau ""
```

Notice that were we to stack these, we could visually decode the
ciphertext back in to the original message:

```text
""imtgdvs""
""fearwer""
""mayoogo""
""anouuio""
""ntnnlvt""
""wttddes""
""aohghn ""
""sseoau ""
```

## Hint

TBD

"
Class {
	#name : #CryptoSquareTest,
	#superclass : #ExercismTest,
	#instVars : [
		'cryptoSquareCalculator'
	],
	#category : #'ExercismWIP-CryptoSquare'
}

{ #category : #config }
CryptoSquareTest class >> uuid [
	"Answer a unique id for this exercise"
	^'982af6d9-2b3f-0d00-a2cf-bf7d09f0590c'
]

{ #category : #config }
CryptoSquareTest class >> version [
	"Generated from specification: 26 February 2019"
	^'3.2.0'
]

{ #category : #setup }
CryptoSquareTest >> setUp [
	cryptoSquareCalculator := CryptoSquare new
]

{ #category : #test }
CryptoSquareTest >> test54CharacterPlaintextResultsIn7ChunksTheLastTwoWithTrailingSpaces [
	| result |

	result := cryptoSquareCalculator ciphertextPlaintext: 'If man was meant to stay on the ground, god would have given us roots.' .
	self assert: result equals: 'imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau '
]

{ #category : #test }
CryptoSquareTest >> test8CharacterPlaintextResultsIn3ChunksTheLastOneWithATrailingSpace [
	| result |

	result := cryptoSquareCalculator ciphertextPlaintext: 'Chill out.' .
	self assert: result equals: 'clu hlt io '
]

{ #category : #test }
CryptoSquareTest >> test9CharacterPlaintextResultsIn3ChunksOf3Characters [
	| result |

	result := cryptoSquareCalculator ciphertextPlaintext: 'This is fun!' .
	self assert: result equals: 'tsf hiu isn'
]

{ #category : #test }
CryptoSquareTest >> testEmptyPlaintextResultsInAnEmptyCiphertext [
	| result |

	result := cryptoSquareCalculator ciphertextPlaintext: '' .
	self assert: result equals: ''
]

{ #category : #test }
CryptoSquareTest >> testLowercase [
	| result |

	result := cryptoSquareCalculator ciphertextPlaintext: 'A' .
	self assert: result equals: 'a'
]

{ #category : #test }
CryptoSquareTest >> testRemovePunctuation [
	| result |

	result := cryptoSquareCalculator ciphertextPlaintext: '@1,%!' .
	self assert: result equals: '1'
]

{ #category : #test }
CryptoSquareTest >> testRemoveSpaces [
	| result |

	result := cryptoSquareCalculator ciphertextPlaintext: '  b ' .
	self assert: result equals: 'b'
]
