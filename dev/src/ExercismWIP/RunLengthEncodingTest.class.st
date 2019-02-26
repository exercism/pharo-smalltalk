"
# Run Length Encoding

Implement run-length encoding and decoding.

Run-length encoding (RLE) is a simple form of data compression, where runs
(consecutive data elements) are replaced by just one data value and count.

For example we can represent the original 53 characters with only 13.

```text
""WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB""  ->  ""12WB12W3B24WB""
```

RLE allows the original data to be perfectly reconstructed from
the compressed data, which makes it a lossless data compression.

```text
""AABCCCDEEEE""  ->  ""2AB3CD4E""  ->  ""AABCCCDEEEE""
```

For simplicity, you can assume that the unencoded string will only contain
the letters A through Z (either lower or upper case) and whitespace. This way
data to be encoded will never contain any numbers and numbers inside data to
be decoded always represent the count for the following character.

## Hint

TBD

"
Class {
	#name : #RunLengthEncodingTest,
	#superclass : #ExercismTest,
	#instVars : [
		'runLengthEncodingCalculator'
	],
	#category : #'ExercismWIP-RunLengthEncoding'
}

{ #category : #config }
RunLengthEncodingTest class >> uuid [
	"Answer a unique id for this exercise"
	^'75dbf9d9-2b3f-0d00-a2d3-6b0f09f0590c'
]

{ #category : #config }
RunLengthEncodingTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
RunLengthEncodingTest >> setUp [
	runLengthEncodingCalculator := RunLengthEncoding new
]

{ #category : #test }
RunLengthEncodingTest >> testEncodeAndThenDecodeEncodeFollowedByDecodeGivesOriginalString [
	| result |

	result := runLengthEncodingCalculator consistencyString: 'zzz ZZ  zZ' .
	self assert: result equals: 'zzz ZZ  zZ'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthDecodeAStringEmptyString [
	| result |

	result := runLengthEncodingCalculator decodeString: '' .
	self assert: result equals: ''
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthDecodeAStringLowerCaseString [
	| result |

	result := runLengthEncodingCalculator decodeString: '2a3b4c' .
	self assert: result equals: 'aabbbcccc'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthDecodeAStringMultipleWhitespaceMixedInString [
	| result |

	result := runLengthEncodingCalculator decodeString: '2 hs2q q2w2 ' .
	self assert: result equals: '  hsqq qww  '
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthDecodeAStringSingleCharactersOnly [
	| result |

	result := runLengthEncodingCalculator decodeString: 'XYZ' .
	self assert: result equals: 'XYZ'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthDecodeAStringSingleCharactersWithRepeatedCharacters [
	| result |

	result := runLengthEncodingCalculator decodeString: '12WB12W3B24WB' .
	self assert: result equals: 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthDecodeAStringStringWithNoSingleCharacters [
	| result |

	result := runLengthEncodingCalculator decodeString: '2A3B4C' .
	self assert: result equals: 'AABBBCCCC'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthEncodeAStringEmptyString [
	| result |

	result := runLengthEncodingCalculator encodeString: '' .
	self assert: result equals: ''
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthEncodeAStringLowercaseCharacters [
	| result |

	result := runLengthEncodingCalculator encodeString: 'aabbbcccc' .
	self assert: result equals: '2a3b4c'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthEncodeAStringMultipleWhitespaceMixedInString [
	| result |

	result := runLengthEncodingCalculator encodeString: '  hsqq qww  ' .
	self assert: result equals: '2 hs2q q2w2 '
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthEncodeAStringSingleCharactersMixedWithRepeatedCharacters [
	| result |

	result := runLengthEncodingCalculator encodeString: 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB' .
	self assert: result equals: '12WB12W3B24WB'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthEncodeAStringSingleCharactersOnlyAreEncodedWithoutCount [
	| result |

	result := runLengthEncodingCalculator encodeString: 'XYZ' .
	self assert: result equals: 'XYZ'
]

{ #category : #test }
RunLengthEncodingTest >> testRunlengthEncodeAStringStringWithNoSingleCharacters [
	| result |

	result := runLengthEncodingCalculator encodeString: 'AABBBCCCC' .
	self assert: result equals: '2A3B4C'
]
