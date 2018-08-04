Class {
	#name : #ReverseString,
	#superclass : #Object,
	#category : #'Exercism-ReverseString'
}

{ #category : #example }
ReverseString >> reverse: aString [
	^ aString size > 1
		ifTrue: [ (self reverse: aString allButFirst) , (String with: aString first) ]
		ifFalse: [ aString ]
]
