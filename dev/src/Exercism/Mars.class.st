Class {
	#name : #Mars,
	#superclass : #Planet,
	#category : #'Exercism-SpaceAge'
}

{ #category : #space }
Mars class >> orbitalPeriod [
	^ Earth orbitalPeriod * 1.8808158
]
