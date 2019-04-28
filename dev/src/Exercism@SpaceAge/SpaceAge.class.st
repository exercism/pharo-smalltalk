"
I return ages in planet-years for planets in the solar system. This solution shows how to use a lazy initialized class variable for a simple lookup table.
"
Class {
	#name : #SpaceAge,
	#superclass : #Object,
	#classVars : [
		'OrbitalPeriods'
	],
	#category : #'Exercism@SpaceAge'
}

{ #category : #exercism }
SpaceAge class >> orbitalPeriods [
	"Answer the orbital period table of different planets in seconds.
	Note: this is the clearest way to define a constant in Pharo although you can also use class #initialize or Pool Dictionaries"

	^ OrbitalPeriods
		ifNil: [ | earthOrbitalPeriod |
			earthOrbitalPeriod := 31557600.
			
			OrbitalPeriods := {('Earth' -> earthOrbitalPeriod).
			('Mercury' -> (earthOrbitalPeriod * 0.2408467)).
			('Venus' -> (earthOrbitalPeriod * 0.61519726)).
			('Mars' -> (earthOrbitalPeriod * 1.8808158)).
			('Jupiter' -> (earthOrbitalPeriod * 11.862615)).
			('Saturn' -> (earthOrbitalPeriod * 29.447498)).
			('Uranus' -> (earthOrbitalPeriod * 84.016846)).
			('Neptune' -> (earthOrbitalPeriod * 164.79132))} asDictionary ]
]

{ #category : #exercism }
SpaceAge >> ageOnPlanet: aPlanet at: aSeconds [
	"Return the age in aPlanet's years at aSeconds old"

	^ aSeconds / (self class orbitalPeriods at: aPlanet)
]
