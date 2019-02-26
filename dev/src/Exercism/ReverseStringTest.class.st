"
# Reverse String

Reverse a string

For example:
input: ""cool""
output: ""looc""

## Hint

TBD

"
Class {
	#name : #ReverseStringTest,
	#superclass : #ExercismTest,
	#instVars : [
		'reverseStringCalculator'
	],
	#category : #'Exercism-ReverseString'
}

{ #category : #config }
ReverseStringTest class >> core [
	"Answer a Boolean, true is this is a core exercise"
	
	^true
]

{ #category : #config }
ReverseStringTest class >> difficulty [
	^1
]

{ #category : #helper }
ReverseStringTest class >> followedBy [
	"If this is a core exercise, answer the next one that follows otherwise nil (if not a core exercise, or the last one)"
	
	^'Hamming'
]

{ #category : #config }
ReverseStringTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('strings' 'iteration' 'text-formatting')
]

{ #category : #config }
ReverseStringTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^LeapTest 
]

{ #category : #config }
ReverseStringTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc10b'
]

{ #category : #config }
ReverseStringTest class >> version [
	"Generated from specification: 25 February 2019"
	^'1.1.0'
]

{ #category : #setup }
ReverseStringTest >> setUp [
	reverseStringCalculator := ReverseString new
]

{ #category : #test }
ReverseStringTest >> testACapitalizedWord [
	| result |

	result := reverseStringCalculator reverseValue: 'Ramen' .
	self assert: result equals: 'nemaR'
]

{ #category : #test }
ReverseStringTest >> testAPalindrome [
	| result |

	result := reverseStringCalculator reverseValue: 'racecar' .
	self assert: result equals: 'racecar'
]

{ #category : #test }
ReverseStringTest >> testASentenceWithPunctuation [
	| result |

	result := reverseStringCalculator reverseValue: 'I''m hungry!' .
	self assert: result equals: '!yrgnuh m''I'
]

{ #category : #test }
ReverseStringTest >> testAWord [
	| result |

	result := reverseStringCalculator reverseValue: 'robot' .
	self assert: result equals: 'tobor'
]

{ #category : #test }
ReverseStringTest >> testAnEmptyString [
	| result |

	result := reverseStringCalculator reverseValue: '' .
	self assert: result equals: ''
]
