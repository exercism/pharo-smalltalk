Class {
	#name : 'Sieve2Test',
	#superclass : 'SieveTest',
	#category : 'Exercise@Sieve-Solution2',
	#package : 'Exercise@Sieve',
	#tag : 'Solution2'
}

{ #category : 'running' }
Sieve2Test >> setUp [
	super setUp.
	sieveCalculator := Sieve2 new
]
