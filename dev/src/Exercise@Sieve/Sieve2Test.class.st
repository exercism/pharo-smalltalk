Class {
	#name : #Sieve2Test,
	#superclass : #SieveTest,
	#category : #'Exercise@Sieve'
}

{ #category : #running }
Sieve2Test >> setUp [
	super setUp.
	sieveCalculator := Sieve2 new
]
