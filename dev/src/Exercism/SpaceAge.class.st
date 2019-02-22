Class {
	#name : #SpaceAge,
	#superclass : #Object,
	#category : #'Exercism-SpaceAge'
}

{ #category : #'space-age' }
SpaceAge class >> on: aPlanet at: anInteger [
	^ anInteger / aPlanet orbitalPeriod asFloat
]
