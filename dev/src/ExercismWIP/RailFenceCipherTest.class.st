"
# Rail Fence Cipher

Implement encoding and decoding for the rail fence cipher.

The Rail Fence cipher is a form of transposition cipher that gets its name from
the way in which it's encoded. It was already used by the ancient Greeks.

In the Rail Fence cipher, the message is written downwards on successive ""rails""
of an imaginary fence, then moving up when we get to the bottom (like a zig-zag).
Finally the message is then read off in rows.

For example, using three ""rails"" and the message ""WE ARE DISCOVERED FLEE AT ONCE"",
the cipherer writes out:

```text
W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . A . . . I . . . V . . . D . . . E . . . N . .
```

Then reads off:

```text
WECRLTEERDSOEEFEAOCAIVDEN
```

To decrypt a message you take the zig-zag shape and fill the ciphertext along the rows.

```text
? . . . ? . . . ? . . . ? . . . ? . . . ? . . . ?
. ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
```

The first row has seven spots that can be filled with ""WECRLTE"".

```text
W . . . E . . . C . . . R . . . L . . . T . . . E
. ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
```

Now the 2nd row takes ""ERDSOEEFEAOC"".

```text
W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
```

Leaving ""AIVDEN"" for the last row.

```text
W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . A . . . I . . . V . . . D . . . E . . . N . .
```

If you now read along the zig-zag shape you can read the original message.

## Hint

TBD

"
Class {
	#name : #RailFenceCipherTest,
	#superclass : #ExercismTest,
	#instVars : [
		'railFenceCipherCalculator'
	],
	#category : #'ExercismWIP-RailFenceCipher'
}

{ #category : #config }
RailFenceCipherTest class >> uuid [
	"Answer a unique id for this exercise"
	^'4c8cecbb-8040-0d00-8135-664d01deb008'
]

{ #category : #config }
RailFenceCipherTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.1.0'
]

{ #category : #setup }
RailFenceCipherTest >> setUp [
	railFenceCipherCalculator := RailFenceCipher new
]

{ #category : #tests }
RailFenceCipherTest >> test01_DecodeDecodeWithThreeRails [
	| result |

	result := railFenceCipherCalculator decodeRails: 3 msg: 'TEITELHDVLSNHDTISEIIEA' .
	self assert: result equals: 'THEDEVILISINTHEDETAILS'
]

{ #category : #tests }
RailFenceCipherTest >> test01_EncodeEncodeWithTwoRails [
	| result |

	result := railFenceCipherCalculator encodeRails: 2 msg: 'XOXOXOXOXOXOXOXOXO' .
	self assert: result equals: 'XXXXXXXXXOOOOOOOOO'
]

{ #category : #tests }
RailFenceCipherTest >> test02_DecodeDecodeWithFiveRails [
	| result |

	result := railFenceCipherCalculator decodeRails: 5 msg: 'EIEXMSMESAORIWSCE' .
	self assert: result equals: 'EXERCISMISAWESOME'
]

{ #category : #tests }
RailFenceCipherTest >> test02_EncodeEncodeWithThreeRails [
	| result |

	result := railFenceCipherCalculator encodeRails: 3 msg: 'WEAREDISCOVEREDFLEEATONCE' .
	self assert: result equals: 'WECRLTEERDSOEEFEAOCAIVDEN'
]

{ #category : #tests }
RailFenceCipherTest >> test03_DecodeDecodeWithSixRails [
	| result |

	result := railFenceCipherCalculator decodeRails: 6 msg: '133714114238148966225439541018335470986172518171757571896261' .
	self assert: result equals: '112358132134558914423337761098715972584418167651094617711286'
]

{ #category : #tests }
RailFenceCipherTest >> test03_EncodeEncodeWithEndingInTheMiddle [
	| result |

	result := railFenceCipherCalculator encodeRails: 4 msg: 'EXERCISES' .
	self assert: result equals: 'ESXIEECSR'
]
