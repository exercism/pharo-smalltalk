Class {
	#name : #Uranus,
	#superclass : #Planet,
	#category : #'Exercism-SpaceAge'
}

{ #category : #space }
Uranus class >> orbitalPeriod [
	^ Earth orbitalPeriod * 84.016846
]
