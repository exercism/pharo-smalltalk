Class {
	#name : #Saturn,
	#superclass : #Planet,
	#category : #'Exercism-SpaceAge'
}

{ #category : #space }
Saturn class >> orbitalPeriod [
	^ Earth orbitalPeriod * 29.447498
]
