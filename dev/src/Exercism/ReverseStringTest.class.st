"
# Reverse String

Reverse a string

For example:
input: ""cool""
output: ""looc""

## Hint

While there is a #reversed method for Strings, can you figure out how to do this yourself using lower level character iteration or streams? 

To help you browse code, Pharo has a neat code finder tool. Press Shift-Enter to activate it.

NOTE: We have followed the Exercism convention of calling the solution ReverseString, however a more Smalltalk name would be StringReverser.

## Smalltalk and Strings

Concerning strings, there are some obvious little details like double quotes for comments, single quotes for strings, and special syntax for characters (e.g., $x for character “x”) that might confuse you on first reading as the conventions are different from those used by other languages. 

There is also the notion of a symbol which is a string that is unique memory-wide; i.e. when it is constructed (typically at compile-time), a memory search is made to determine if another one like it exists; and only the original is used. The rationale is not just memory saving but significant speed-up when comparing symbols.

```smalltalk
""this is a comment""
'this is a string'
#'this is a symbol'
#thisIsASymbolToo
```

There are also very few commas in Smalltalk programs because they play no syntactic role.
That’s why array literals, for example, are comma-free; e.g.
`#(1 2 3 4 5)`
However, comma is an operator in its own right and you will notice it when concatenating two strings; e.g.
`'string1', 'string2'`

Finally, it's worth knowing that strings are collections of characters. This can catch you off guard when iterating over strings as you can end up giving characters to a method that expects strings.
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
	"If this is a core exercise, answer the next one that follows otherwise nil"
	
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
	
	^nil 
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

{ #category : #tests }
ReverseStringTest >> test01_AnEmptyString [
	| result |

	result := reverseStringCalculator reverseValue: '' .
	self assert: result equals: ''
]

{ #category : #tests }
ReverseStringTest >> test02_AWord [
	| result |

	result := reverseStringCalculator reverseValue: 'robot' .
	self assert: result equals: 'tobor'
]

{ #category : #tests }
ReverseStringTest >> test03_ACapitalizedWord [
	| result |

	result := reverseStringCalculator reverseValue: 'Ramen' .
	self assert: result equals: 'nemaR'
]

{ #category : #tests }
ReverseStringTest >> test04_ASentenceWithPunctuation [
	| result |

	result := reverseStringCalculator reverseValue: 'I''m hungry!' .
	self assert: result equals: '!yrgnuh m''I'
]

{ #category : #tests }
ReverseStringTest >> test05_APalindrome [
	| result |

	result := reverseStringCalculator reverseValue: 'racecar' .
	self assert: result equals: 'racecar'
]

{ #category : #test }
ReverseStringTest >> testMisuseOfSelector [
	self verifySolution: reverseStringCalculator class avoidsSelector: #reverse
]
