"
I am Venus, from the Sol system
"
Class {
	#name : #Venus,
	#superclass : #Planet,
	#category : #'Exercism-SpaceAge'
}

{ #category : #space }
Venus class >> orbitalPeriod [
	^ Earth orbitalPeriod * 0.61519726
]
