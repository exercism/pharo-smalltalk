"
I return ages in planet-years for planets in the solar system.
"
Class {
	#name : #SpaceAge,
	#superclass : #Object,
	#classVars : [
		'OrbitalPeriods'
	],
	#category : #'Exercism-SpaceAge'
}

{ #category : #'class initialization' }
SpaceAge class >> initialize [
	self initializeOrbitalPeriods
]

{ #category : #initialization }
SpaceAge class >> initializeOrbitalPeriods [
	"Initialize orbital periods in seconds for each solar system planet"

	| earthOrbitalPeriod |
	earthOrbitalPeriod := 31557600.
	OrbitalPeriods := Dictionary new
		at: 'Mercury' put: earthOrbitalPeriod * 0.2408467;
		at: 'Venus' put: earthOrbitalPeriod * 0.61519726;
		at: 'Earth' put: earthOrbitalPeriod;
		at: 'Mars' put: earthOrbitalPeriod * 1.8808158;
		at: 'Jupiter' put: earthOrbitalPeriod * 11.862615;
		at: 'Saturn' put: earthOrbitalPeriod * 29.447498;
		at: 'Uranus' put: earthOrbitalPeriod * 84.016846;
		at: 'Neptune' put: earthOrbitalPeriod * 164.79132;
		yourself
]

{ #category : #exercism }
SpaceAge >> ageOnPlanet: aPlanet at: aSeconds [
	"Return the age in aPlanet's years at aSeconds old"
	^ aSeconds / (self orbitalPeriodOn: aPlanet)
]

{ #category : #exercism }
SpaceAge >> orbitalPeriodOn: aString [
	^ OrbitalPeriods at: aString
]
