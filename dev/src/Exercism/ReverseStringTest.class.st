"
# Reverse String 

Reverse a string

For example:
input: ""cool""
output: ""looc""

## Hint 

While there is a #reversed method for Strings, can you figure out how to do this yourself with lower level character iteration or streams? 

To help you browse code, Pharo has a neat code finder tool (called Spotter). Press Shift-Enter to activate it.

NOTE: We have followed the Exercism convention of calling the solution ReverseString, however a more Smalltalk name would be StringReverser.

### Smalltalk and Strings

There are some obvious little details like double quotes for comments, single quotes for strings, and
special syntax for characters (e.g., $x for character “x”) that might confuse you on first reading since the conventions might be different from that used by other languages. There is also the notion of a symbol which is a string that is unique memory-wide; i.e. when it is constructed (typically at compile-time), a memory search is made to determine if another one like it exists; only the original is used. The rationale is not memory saving but significant speed-up when comparing symbols.

```smalltalk
""this is a comment""
'this is a string'
#'this is a symbol'
#thisIsASymbolToo
```

There are also very few commas evident in Smalltalk programs because they play no syntactic role.
That’s why array literals, for example, are comma-free; e.g. `#(1 2 3 4 5)`
However, comma is an operator. So you will see it used now and then to concatenate two strings; e.g.
`'string1', 'string2'`

Lastly it's worth knowing that strings are collections of characters. This can catch you off guard when iterating over strings if you are giving characters to a method that expects strings.

"
Class {
	#name : #ReverseStringTest,
	#superclass : #ExercismTest,
	#instVars : [
		'stringReverser'
	],
	#category : #'Exercism-ReverseString'
}

{ #category : #meta }
ReverseStringTest class >> core [
	"Answer a Boolean, true is this is a core exercise"
	
	^true
]

{ #category : #meta }
ReverseStringTest class >> difficulty [
	^1
]

{ #category : #config }
ReverseStringTest class >> followedBy [
	"If this is a core exercise, answer the next one that follows otherwise nil (if not a core exercise, or the last one)"
	
	^'Hamming'
]

{ #category : #meta }
ReverseStringTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('strings' 'iteration' 'text-formatting')
]

{ #category : #config }
ReverseStringTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^LeapTest 
]

{ #category : #meta }
ReverseStringTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc10b'
]

{ #category : #config }
ReverseStringTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^'1.1.0'
]

{ #category : #setup }
ReverseStringTest >> setUp [
	stringReverser := ReverseString new
]

{ #category : #testing }
ReverseStringTest >> testCapitalisedWorld [
	self 
		assert: (stringReverser reverse: 'Ramen') 
		equals: 'nemaR'
]

{ #category : #testing }
ReverseStringTest >> testEmptyString [
	self 
		assert: (stringReverser reverse: '') 
		equals: ''
]

{ #category : #testing }
ReverseStringTest >> testSentenceWithPunctuation [
	self 
		assert: (stringReverser reverse: 'I''m hungry!') 
		equals: '!yrgnuh m''I'
]

{ #category : #testing }
ReverseStringTest >> testSingleWorld [
	self
		assert: (stringReverser reverse: 'robot')
		equals: 'tobor'
]

{ #category : #testing }
ReverseStringTest >> testWithPalindrome [
	self
		assert: (stringReverser reverse: 'racecar')
		equals: 'racecar'

]
