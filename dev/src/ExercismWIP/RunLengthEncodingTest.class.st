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
	^'1d19c516-9d41-0d00-8fe2-de9208866539'
]

{ #category : #config }
RunLengthEncodingTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #setup }
RunLengthEncodingTest >> setUp [
	runLengthEncodingCalculator := RunLengthEncoding new
]

{ #category : #tests }
RunLengthEncodingTest >> test01_RunlengthEncodeAStringEmptyString [
	| result |

	result := runLengthEncodingCalculator encodeString: '' .
	self assert: result equals: ''
]

{ #category : #tests }
RunLengthEncodingTest >> test02_RunlengthEncodeAStringSingleCharactersOnlyAreEncodedWithoutCount [
	| result |

	result := runLengthEncodingCalculator encodeString: 'XYZ' .
	self assert: result equals: 'XYZ'
]

{ #category : #tests }
RunLengthEncodingTest >> test03_RunlengthEncodeAStringStringWithNoSingleCharacters [
	| result |

	result := runLengthEncodingCalculator encodeString: 'AABBBCCCC' .
	self assert: result equals: '2A3B4C'
]

{ #category : #tests }
RunLengthEncodingTest >> test04_RunlengthEncodeAStringSingleCharactersMixedWithRepeatedCharacters [
	| result |

	result := runLengthEncodingCalculator encodeString: 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB' .
	self assert: result equals: '12WB12W3B24WB'
]

{ #category : #tests }
RunLengthEncodingTest >> test05_RunlengthEncodeAStringMultipleWhitespaceMixedInString [
	| result |

	result := runLengthEncodingCalculator encodeString: '  hsqq qww  ' .
	self assert: result equals: '2 hs2q q2w2 '
]

{ #category : #tests }
RunLengthEncodingTest >> test06_RunlengthEncodeAStringLowercaseCharacters [
	| result |

	result := runLengthEncodingCalculator encodeString: 'aabbbcccc' .
	self assert: result equals: '2a3b4c'
]

{ #category : #tests }
RunLengthEncodingTest >> test07_RunlengthDecodeAStringEmptyString [
	| result |

	result := runLengthEncodingCalculator decodeString: '' .
	self assert: result equals: ''
]

{ #category : #tests }
RunLengthEncodingTest >> test08_RunlengthDecodeAStringSingleCharactersOnly [
	| result |

	result := runLengthEncodingCalculator decodeString: 'XYZ' .
	self assert: result equals: 'XYZ'
]

{ #category : #tests }
RunLengthEncodingTest >> test09_RunlengthDecodeAStringStringWithNoSingleCharacters [
	| result |

	result := runLengthEncodingCalculator decodeString: '2A3B4C' .
	self assert: result equals: 'AABBBCCCC'
]

{ #category : #tests }
RunLengthEncodingTest >> test10_RunlengthDecodeAStringSingleCharactersWithRepeatedCharacters [
	| result |

	result := runLengthEncodingCalculator decodeString: '12WB12W3B24WB' .
	self assert: result equals: 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB'
]

{ #category : #tests }
RunLengthEncodingTest >> test11_RunlengthDecodeAStringMultipleWhitespaceMixedInString [
	| result |

	result := runLengthEncodingCalculator decodeString: '2 hs2q q2w2 ' .
	self assert: result equals: '  hsqq qww  '
]

{ #category : #tests }
RunLengthEncodingTest >> test12_RunlengthDecodeAStringLowerCaseString [
	| result |

	result := runLengthEncodingCalculator decodeString: '2a3b4c' .
	self assert: result equals: 'aabbbcccc'
]

{ #category : #tests }
RunLengthEncodingTest >> test13_EncodeAndThenDecodeEncodeFollowedByDecodeGivesOriginalString [
	| result |

	result := runLengthEncodingCalculator consistencyString: 'zzz ZZ  zZ' .
	self assert: result equals: 'zzz ZZ  zZ'
]
