"
I represent facts about planets
"
Class {
	#name : #Planet,
	#superclass : #Object,
	#category : #'Exercism-SpaceAge'
}

{ #category : #testing }
Planet class >> isAbstract [
	^ self name = #Planet
]

{ #category : #space }
Planet class >> orbitalPeriod [
	"Return the orbital period of the planet in seconds"

	self subclassResponsibility
]
