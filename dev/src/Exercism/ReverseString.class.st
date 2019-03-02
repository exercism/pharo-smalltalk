"
This solution shows a linear approach to solving the problem, but also has an example of a recursive version.

Of note, is the use of the message #species new, to create a result of the same type as the parameter.
"
Class {
	#name : #ReverseString,
	#superclass : #Object,
	#category : #'Exercism-ReverseString'
}

{ #category : #exercism }
ReverseString >> indexedReverse: aString [
	| result offset |
	result := String new: aString size.
	offset := aString size + 1.
	aString doWithIndex: [ :char :i | result at: offset - i put: char ].
	^ result
]

{ #category : #example }
ReverseString >> recursiveReverse: aString [
	^ aString size > 1
		ifTrue: [ (self recursiveReverse: aString allButFirst) , (String with: aString first) ]
		ifFalse: [ aString ]
]

{ #category : #exercism }
ReverseString >> reverseValue: aString [

	^ String streamContents: [ :stream |
		aString size to: 1 by: -1 do: [ :i |
			stream nextPut: (aString at: i) ]]
]
