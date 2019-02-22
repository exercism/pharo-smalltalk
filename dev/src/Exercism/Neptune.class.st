Class {
	#name : #Neptune,
	#superclass : #Planet,
	#category : #'Exercism-SpaceAge'
}

{ #category : #space }
Neptune class >> orbitalPeriod [
	^ Earth orbitalPeriod * 164.79132
]
