"
This is pretty straight forward if the soluton uses c = sqrt of a^2 + b^2
"
Class {
	#name : #Darts,
	#superclass : #Object,
	#category : #'Exercism@Darts'
}

{ #category : #scoring }
Darts >> scoreX: anInteger y: anotherInteger [ 
	| length |
	
	length := (anInteger squared + anotherInteger squared) sqrt.
	length > 10 ifTrue: [ ^ 0 ].
	length > 5 ifTrue: [ ^ 1 ].
	length > 1 ifTrue: [ ^ 5 ].
	^ 10
]
