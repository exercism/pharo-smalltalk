Class {
	#name : #CollatzConjecture,
	#superclass : #Object,
	#category : #'ExercismWIP-CollatzConjecture'
}

{ #category : #calculating }
CollatzConjecture >> collatzStep: anInteger [
	^ anInteger even
		ifTrue: [ anInteger // 2 ]
		ifFalse: [ anInteger * 3 + 1 ]
]

{ #category : #calculating }
CollatzConjecture >> stepsNumber: anInteger [ 
	^ anInteger // 4
]
