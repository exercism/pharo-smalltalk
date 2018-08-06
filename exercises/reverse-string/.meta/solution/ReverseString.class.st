"
Thist solution shows a linear approach to solving the problem, but also has an example of a recursive version.

Of note, is the use of the message #species new, to create a result of the same type as the parameter.
"
Class {
	#name : #ReverseString,
	#superclass : #Object,
	#category : #'Exercism-ReverseString'
}

{ #category : #example }
ReverseString >> recursiveReverse: aString [
	^ aString size > 1
		ifTrue: [ (self recursiveReverse: aString allButFirst) , (String with: aString first) ]
		ifFalse: [ aString ]
]

{ #category : #example }
ReverseString >> reverse: aCollection [
	| result offset |
	result := aCollection species
		new: aCollection size.
	offset := aCollection size + 1.
	aCollection
		doWithIndex:
			[ :char :i | result at: offset - i put: char ].
	^ result
]
