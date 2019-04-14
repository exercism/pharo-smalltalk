Class {
	#name : #CollatzConjecture,
	#superclass : #Object,
	#category : #'Exercism-CollatzConjecture'
}

{ #category : #calculating }
CollatzConjecture >> collatzStep: anInteger [
	^ anInteger even
		ifTrue: [ anInteger // 2 ]
		ifFalse: [ anInteger * 3 + 1 ]
]

{ #category : #calculating }
CollatzConjecture >> recursiveCollatzStep: steps value: anInteger [
	^ anInteger = 1
		ifTrue: [ ^ steps ]
		ifFalse: [ 
			self
				recursiveCollatzStep: steps + 1
				value: (self collatzStep: anInteger) ]
]

{ #category : #calculating }
CollatzConjecture >> stepsNumber: anInteger [
	anInteger <= 0
		ifTrue: [ DomainError signal: 'Only positive numbers are allowed' ].
		
	^ self recursiveCollatzStep: 0 value: anInteger
]
