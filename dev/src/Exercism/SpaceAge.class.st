"
I calculate ages in planet-years for different planets
"
Class {
	#name : #SpaceAge,
	#superclass : #Object,
	#category : #'Exercism-SpaceAge'
}

{ #category : #'space-age' }
SpaceAge class >> on: aPlanet at: anInteger [
	"Calculate the age in aPlanet's years of someone who is anInteger seconds old"
	^ anInteger / aPlanet orbitalPeriod asFloat
]
