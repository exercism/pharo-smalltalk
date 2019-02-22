Class {
	#name : #Jupiter,
	#superclass : #Planet,
	#category : #'Exercism-SpaceAge'
}

{ #category : #space }
Jupiter class >> orbitalPeriod [
	^ Earth orbitalPeriod * 11.862615
]
