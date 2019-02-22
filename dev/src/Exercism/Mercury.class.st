"
I am Mercury, from the Sol system
"
Class {
	#name : #Mercury,
	#superclass : #Planet,
	#category : #'Exercism-SpaceAge'
}

{ #category : #space }
Mercury class >> orbitalPeriod [
	^ Earth orbitalPeriod * 0.2408467
]
