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
	^'065da42e-b043-0d00-9248-fda102a76407'
]

{ #category : #config }
VariableLengthQuantityTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.2.0'
]

{ #category : #setup }
VariableLengthQuantityTest >> setUp [
	variableLengthQuantityCalculator := VariableLengthQuantity new
]

{ #category : #tests }
VariableLengthQuantityTest >> test01_EncodeASeriesOfIntegersProducingASeriesOfBytesZero [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(0 ) .
	self assert: result equals: #(0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test02_EncodeASeriesOfIntegersProducingASeriesOfBytesArbitrarySingleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(64 ) .
	self assert: result equals: #(64 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test03_EncodeASeriesOfIntegersProducingASeriesOfBytesLargestSingleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(127 ) .
	self assert: result equals: #(127 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test04_EncodeASeriesOfIntegersProducingASeriesOfBytesSmallestDoubleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(128 ) .
	self assert: result equals: #(129 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test05_EncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryDoubleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(8192 ) .
	self assert: result equals: #(192 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test06_EncodeASeriesOfIntegersProducingASeriesOfBytesLargestDoubleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(16383 ) .
	self assert: result equals: #(255 127 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test07_EncodeASeriesOfIntegersProducingASeriesOfBytesSmallestTripleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(16384 ) .
	self assert: result equals: #(129 128 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test08_EncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryTripleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(1048576 ) .
	self assert: result equals: #(192 128 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test09_EncodeASeriesOfIntegersProducingASeriesOfBytesLargestTripleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(2097151 ) .
	self assert: result equals: #(255 255 127 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test10_EncodeASeriesOfIntegersProducingASeriesOfBytesSmallestQuadrupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(2097152 ) .
	self assert: result equals: #(129 128 128 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test11_EncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryQuadrupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(134217728 ) .
	self assert: result equals: #(192 128 128 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test12_EncodeASeriesOfIntegersProducingASeriesOfBytesLargestQuadrupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(268435455 ) .
	self assert: result equals: #(255 255 255 127 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test13_EncodeASeriesOfIntegersProducingASeriesOfBytesSmallestQuintupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(268435456 ) .
	self assert: result equals: #(129 128 128 128 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test14_EncodeASeriesOfIntegersProducingASeriesOfBytesArbitraryQuintupleByte [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(4278190080 ) .
	self assert: result equals: #(143 248 128 128 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test15_EncodeASeriesOfIntegersProducingASeriesOfBytesMaximum32bitIntegerInput [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(4294967295 ) .
	self assert: result equals: #(143 255 255 255 127 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test16_EncodeASeriesOfIntegersProducingASeriesOfBytesTwoSinglebyteValues [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(64 127 ) .
	self assert: result equals: #(64 127 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test17_EncodeASeriesOfIntegersProducingASeriesOfBytesTwoMultibyteValues [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(16384 1193046 ) .
	self assert: result equals: #(129 128 0 200 232 86 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test18_EncodeASeriesOfIntegersProducingASeriesOfBytesManyMultibyteValues [
	| result |

	result := variableLengthQuantityCalculator encodeIntegers: #(8192 1193046 268435455 0 16383 16384 ) .
	self assert: result equals: #(192 0 200 232 86 255 255 255 127 0 255 127 129 128 0 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test19_DecodeASeriesOfBytesProducingASeriesOfIntegersOneByte [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(127 ) .
	self assert: result equals: #(127 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test20_DecodeASeriesOfBytesProducingASeriesOfIntegersTwoBytes [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(192 0 ) .
	self assert: result equals: #(8192 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test21_DecodeASeriesOfBytesProducingASeriesOfIntegersThreeBytes [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(255 255 127 ) .
	self assert: result equals: #(2097151 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test22_DecodeASeriesOfBytesProducingASeriesOfIntegersFourBytes [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(129 128 128 0 ) .
	self assert: result equals: #(2097152 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test23_DecodeASeriesOfBytesProducingASeriesOfIntegersMaximum32bitInteger [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(143 255 255 255 127 ) .
	self assert: result equals: #(4294967295 )
]

{ #category : #tests }
VariableLengthQuantityTest >> test24_DecodeASeriesOfBytesProducingASeriesOfIntegersIncompleteSequenceCausesError [
	| result |

	self
		should: [ result := variableLengthQuantityCalculator decodeIntegers: #(255 ) ]
		raise: Exception
		whoseDescriptionIncludes: 'incomplete sequence'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
VariableLengthQuantityTest >> test25_DecodeASeriesOfBytesProducingASeriesOfIntegersIncompleteSequenceCausesErrorEvenIfValueIsZero [
	| result |

	self
		should: [ result := variableLengthQuantityCalculator decodeIntegers: #(128 ) ]
		raise: Exception
		whoseDescriptionIncludes: 'incomplete sequence'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
VariableLengthQuantityTest >> test26_DecodeASeriesOfBytesProducingASeriesOfIntegersMultipleValues [
	| result |

	result := variableLengthQuantityCalculator decodeIntegers: #(192 0 200 232 86 255 255 255 127 0 255 127 129 128 0 ) .
	self assert: result equals: #(8192 1193046 268435455 0 16383 16384 )
]
