"
# Word Count

Given a phrase, count the occurrences of each word in that phrase.

For example for the input `""olly olly in come free""`

```text
olly: 2
in: 1
come: 1
free: 1
```

## Hint

TBD

"
Class {
	#name : #WordCountTest,
	#superclass : #ExercismTest,
	#instVars : [
		'wordCountCalculator'
	],
	#category : #'ExercismWIP-WordCount'
}

{ #category : #config }
WordCountTest class >> uuid [
	"Answer a unique id for this exercise"
	^'7c4627da-2b3f-0d00-a2fc-01ec09f0590c'
]

{ #category : #config }
WordCountTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.3.0'
]

{ #category : #setup }
WordCountTest >> setUp [
	wordCountCalculator := WordCount new
]

{ #category : #test }
WordCountTest >> testAlternatingWordSeparatorsNotDetectedAsAWord [
	| result |

	result := wordCountCalculator countWordsSentence: ',
,one,
 ,two 
 ''three''' .
	self assert: result equals: ((Dictionary new) add: ('two'->1); add: ('one'->1); add: ('three'->1); yourself)
]

{ #category : #test }
WordCountTest >> testCountOneOfEachWord [
	| result |

	result := wordCountCalculator countWordsSentence: 'one of each' .
	self assert: result equals: ((Dictionary new) add: ('of'->1); add: ('each'->1); add: ('one'->1); yourself)
]

{ #category : #test }
WordCountTest >> testCountOneWord [
	| result |

	result := wordCountCalculator countWordsSentence: 'word' .
	self assert: result equals: ((Dictionary new) add: ('word'->1); yourself)
]

{ #category : #test }
WordCountTest >> testHandlesCrampedLists [
	| result |

	result := wordCountCalculator countWordsSentence: 'one,two,three' .
	self assert: result equals: ((Dictionary new) add: ('two'->1); add: ('one'->1); add: ('three'->1); yourself)
]

{ #category : #test }
WordCountTest >> testHandlesExpandedLists [
	| result |

	result := wordCountCalculator countWordsSentence: 'one,
two,
three' .
	self assert: result equals: ((Dictionary new) add: ('two'->1); add: ('one'->1); add: ('three'->1); yourself)
]

{ #category : #test }
WordCountTest >> testIgnorePunctuation [
	| result |

	result := wordCountCalculator countWordsSentence: 'car: carpet as java: javascript!!&@$%^&' .
	self assert: result equals: ((Dictionary new) add: ('as'->1); add: ('javascript'->1); add: ('java'->1); add: ('car'->1); add: ('carpet'->1); yourself)
]

{ #category : #test }
WordCountTest >> testIncludeNumbers [
	| result |

	result := wordCountCalculator countWordsSentence: 'testing, 1, 2 testing' .
	self assert: result equals: ((Dictionary new) add: ('testing'->2); add: ('1'->1); add: ('2'->1); yourself)
]

{ #category : #test }
WordCountTest >> testMultipleOccurrencesOfAWord [
	| result |

	result := wordCountCalculator countWordsSentence: 'one fish two fish red fish blue fish' .
	self assert: result equals: ((Dictionary new) add: ('blue'->1); add: ('fish'->4); add: ('one'->1); add: ('red'->1); add: ('two'->1); yourself)
]

{ #category : #test }
WordCountTest >> testMultipleSpacesNotDetectedAsAWord [
	| result |

	result := wordCountCalculator countWordsSentence: ' multiple   whitespaces' .
	self assert: result equals: ((Dictionary new) add: ('multiple'->1); add: ('whitespaces'->1); yourself)
]

{ #category : #test }
WordCountTest >> testNormalizeCase [
	| result |

	result := wordCountCalculator countWordsSentence: 'go Go GO Stop stop' .
	self assert: result equals: ((Dictionary new) add: ('stop'->2); add: ('go'->3); yourself)
]

{ #category : #test }
WordCountTest >> testWithApostrophes [
	| result |

	result := wordCountCalculator countWordsSentence: 'First: don''t laugh. Then: don''t cry.' .
	self assert: result equals: ((Dictionary new) add: ('cry'->1); add: ('don''t'->2); add: ('laugh'->1); add: ('first'->1); add: ('then'->1); yourself)
]

{ #category : #test }
WordCountTest >> testWithQuotations [
	| result |

	result := wordCountCalculator countWordsSentence: 'Joe can''t tell between ''large'' and large.' .
	self assert: result equals: ((Dictionary new) add: ('large'->2); add: ('joe'->1); add: ('can''t'->1); add: ('and'->1); add: ('tell'->1); add: ('between'->1); yourself)
]
