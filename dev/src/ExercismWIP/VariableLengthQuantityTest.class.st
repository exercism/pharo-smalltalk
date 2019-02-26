"
# Variable Length Quantity

Implement variable length quantity encoding and decoding.

The goal of this exercise is to implement [VLQ](https://en.wikipedia.org/wiki/Variable-length_quantity) encoding/decoding.

In short, the goal of this encoding is to encode integer values in a way that would save bytes.
Only the first 7 bits of each byte is significant (right-justified; sort of like an ASCII byte).
So, if you have a 32-bit value, you have to unpack it into a series of 7-bit bytes.
Of course, you will have a variable number of bytes depending upon your integer.
To indicate which is the last byte of the series, you leave bit #7 clear.
In all of the preceding bytes, you set bit #7.

So, if an integer is between `0-127`, it can be represented as one byte.
Although VLQ can deal with numbers of arbitrary sizes, for this exercise we will restrict ourselves to only numbers that fit in a 32-bit unsigned integer.
Here are examples of integers as 32-bit values, and the variable length quantities that they translate to:

```text
 NUMBER        VARIABLE QUANTITY
00000000              00
00000040              40
0000007F              7F
00000080             81 00
00002000             C0 00
00003FFF             FF 7F
00004000           81 80 00
00100000           C0 80 00
001FFFFF           FF FF 7F
00200000          81 80 80 00
08000000          C0 80 80 00
0FFFFFFF          FF FF FF 7F
```

## Hint

TBD

"
Class {
	#name : #VariableLengthQuantityTest,
	#superclass : #ExercismTest,
	#instVars : [
		'variableLengthQuantityCalculator'
	],
	#category : #'ExercismWIP-VariableLengthQuantity'
}

{ #category : #config }
VariableLengthQuantityTest class >> uuid [
	"Answer a unique id for this exercise"
	^'f9e0ddd9-2b3f-0d00-a2b5-ab8309f0590c'
]

{ #category : #config }
VariableLengthQuantityTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
VariableLengthQuantityTest >> setUp [
	variableLengthQuantityCalculator := VariableLengthQuantity new
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersFourBytes [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(129 128 128 0 ) .
	self assert: result equals: #(2097152 )
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersIncompleteSequenceCausesError [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(255 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'incomplete sequence'); yourself)
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersIncompleteSequenceCausesErrorEvenIfValueIsZero [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(128 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'incomplete sequence'); yourself)
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersMaximum32bitInteger [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(143 255 255 255 127 ) .
	self assert: result equals: #(4294967295 )
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersMultipleValues [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(192 0 200 232 86 255 255 255 127 0 255 127 129 128 0 ) .
	self assert: result equals: #(8192 1193046 268435455 0 16383 16384 )
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersOneByte [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(127 ) .
	self assert: result equals: #(127 )
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersThreeBytes [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(255 255 127 ) .
	self assert: result equals: #(2097151 )
]

{ #category : #test }
VariableLengthQuantityTest >> testDecodeASeriesOfBytesProducingASeriesOfIntegersTwoBytes [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(192 0 ) .
	self assert: result equals: #(8192 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryDoubleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(8192 ) .
	self assert: result equals: #(192 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryQuadrupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(134217728 ) .
	self assert: result equals: #(192 128 128 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryQuintupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(4278190080 ) .
	self assert: result equals: #(143 248 128 128 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesArbitrarySingleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(64 ) .
	self assert: result equals: #(64 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryTripleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(1048576 ) .
	self assert: result equals: #(192 128 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesLargestDoubleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(16383 ) .
	self assert: result equals: #(255 127 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesLargestQuadrupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(268435455 ) .
	self assert: result equals: #(255 255 255 127 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesLargestSingleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(127 ) .
	self assert: result equals: #(127 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesLargestTripleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(2097151 ) .
	self assert: result equals: #(255 255 127 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesManyMultibyteValues [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(8192 1193046 268435455 0 16383 16384 ) .
	self assert: result equals: #(192 0 200 232 86 255 255 255 127 0 255 127 129 128 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesMaximum32bitIntegerInput [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(4294967295 ) .
	self assert: result equals: #(143 255 255 255 127 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesSmallestDoubleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(128 ) .
	self assert: result equals: #(129 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesSmallestQuadrupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(2097152 ) .
	self assert: result equals: #(129 128 128 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesSmallestQuintupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(268435456 ) .
	self assert: result equals: #(129 128 128 128 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesSmallestTripleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(16384 ) .
	self assert: result equals: #(129 128 0 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesTwoMultibyteValues [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(16384 1193046 ) .
	self assert: result equals: #(129 128 0 200 232 86 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesTwoSinglebyteValues [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(64 127 ) .
	self assert: result equals: #(64 127 )
]

{ #category : #test }
VariableLengthQuantityTest >> testEncodeASeriesOfIntegersProducingASeriesOfBytesZero [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(0 ) .
	self assert: result equals: #(0 )
]
