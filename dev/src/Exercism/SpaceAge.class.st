"
I return ages in planet-years for planets in the solar system.
"
Class {
	#name : #SpaceAge,
	#superclass : #Object,
	#category : #'Exercism-SpaceAge'
}

{ #category : #exercism }
SpaceAge >> ageOnPlanet: aPlanet at: aSeconds [
	"Return the age in aPlanet's years at aSeconds old"

	^ aSeconds / (self orbitalPeriodOn: aPlanet)
]

{ #category : #exercism }
SpaceAge >> orbitalPeriodOn: aPlanet [
	"Return the orbital period of a planet in seconds"

	| earthOrbitalPeriod |
	earthOrbitalPeriod := 31557600.
	^ {('Earth' -> earthOrbitalPeriod).
	('Mercury' -> (earthOrbitalPeriod * 0.2408467)).
	('Venus' -> (earthOrbitalPeriod * 0.61519726)).
	('Mars' -> (earthOrbitalPeriod * 1.8808158)).
	('Jupiter' -> (earthOrbitalPeriod * 11.862615)).
	('Saturn' -> (earthOrbitalPeriod * 29.447498)).
	('Uranus' -> (earthOrbitalPeriod * 84.016846)).
	('Neptune' -> (earthOrbitalPeriod * 164.79132))} asDictionary
		at: aPlanet
]
