"
# Space Age

Given an age in seconds, calculate how old someone would be on:

   - Earth: orbital period 365.25 Earth days, or 31557600 seconds
   - Mercury: orbital period 0.2408467 Earth years
   - Venus: orbital period 0.61519726 Earth years
   - Mars: orbital period 1.8808158 Earth years
   - Jupiter: orbital period 11.862615 Earth years
   - Saturn: orbital period 29.447498 Earth years
   - Uranus: orbital period 84.016846 Earth years
   - Neptune: orbital period 164.79132 Earth years

So if you were told someone were 1,000,000,000 seconds old, you should
be able to say that they're 31.69 Earth-years old.

If you're wondering why Pluto didn't make the cut, go watch [this
youtube video](http://www.youtube.com/watch?v=Z_2gbGXzFbs).

## Hint

TBD

"
Class {
	#name : #SpaceAgeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'spaceAgeCalculator'
	],
	#category : #'ExercismWIP-SpaceAge'
}

{ #category : #meta }
SpaceAgeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'9935e5bc-163f-0d00-afa0-9b980aec9142'
]

{ #category : #meta }
SpaceAgeTest class >> version [
	"Generated from specification: 25 February 2019"
	^'1.2.0'
]

{ #category : #setup }
SpaceAgeTest >> setUp [
	spaceAgeCalculator := SpaceAge new
]

{ #category : #test }
SpaceAgeTest >> testAgeOnEarth [
	| result |

	result := spaceAgeCalculator agePlanet: 'Earth' seconds: 1000000000 .
	self assert: result equals: 31.69
]

{ #category : #test }
SpaceAgeTest >> testAgeOnJupiter [
	| result |

	result := spaceAgeCalculator agePlanet: 'Jupiter' seconds: 901876382 .
	self assert: result equals: 2.41
]

{ #category : #test }
SpaceAgeTest >> testAgeOnMars [
	| result |

	result := spaceAgeCalculator agePlanet: 'Mars' seconds: 2129871239 .
	self assert: result equals: 35.88
]

{ #category : #test }
SpaceAgeTest >> testAgeOnMercury [
	| result |

	result := spaceAgeCalculator agePlanet: 'Mercury' seconds: 2134835688 .
	self assert: result equals: 280.88
]

{ #category : #test }
SpaceAgeTest >> testAgeOnNeptune [
	| result |

	result := spaceAgeCalculator agePlanet: 'Neptune' seconds: 1821023456 .
	self assert: result equals: 0.35
]

{ #category : #test }
SpaceAgeTest >> testAgeOnSaturn [
	| result |

	result := spaceAgeCalculator agePlanet: 'Saturn' seconds: 2000000000 .
	self assert: result equals: 2.15
]

{ #category : #test }
SpaceAgeTest >> testAgeOnUranus [
	| result |

	result := spaceAgeCalculator agePlanet: 'Uranus' seconds: 1210123456 .
	self assert: result equals: 0.46
]

{ #category : #test }
SpaceAgeTest >> testAgeOnVenus [
	| result |

	result := spaceAgeCalculator agePlanet: 'Venus' seconds: 189839836 .
	self assert: result equals: 9.78
]
