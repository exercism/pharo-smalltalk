"
A simple solution to bracket exercise using a Stack
"
Class {
	#name : #MatchingBrackets,
	#superclass : #Object,
	#category : #'Exercise@MatchingBrackets'
}

{ #category : #'private-constants' }
MatchingBrackets >> delimiterPairs [
	^ #('()' '[]' '{}')
]

{ #category : #'private-testing' }
MatchingBrackets >> is: closeChar closingBracketFor: openChar [
	^ self delimiterPairs
		detect: [ :each | each first = openChar & (each last = closeChar) ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #exercism }
MatchingBrackets >> isPaired: aString [
	| stack |
	
	stack := Stack new.
	aString do: [ :each |
		each isOpenPunctuation ifTrue: [ stack push: each ].
		each isClosePunctuation
			ifTrue: [
				stack isEmpty ifTrue: [ ^ false ].
				(self is: each closingBracketFor: stack top)
					ifTrue: [ stack pop ]
					ifFalse: [ ^ false ] ] ].
	^ stack isEmpty
]
