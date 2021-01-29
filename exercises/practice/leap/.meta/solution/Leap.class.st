"
This is a sample solution for Exercism students.

Of interest, in this example is that boolean operations like and: and or: are implemented as message sends on bolean objects. You can even browse their implementations - lookup 'and:' in the gtSpotter.
"
Class {
	#name : #Leap,
	#superclass : #Object,
	#category : #'Exercise@Leap'
}

{ #category : #exercism }
Leap >> leapYear: anInteger [
	^ (anInteger isDivisibleBy: 4)
		and: [ (anInteger isDivisibleBy: 400)
				or: [ (anInteger isDivisibleBy: 100) not ] ]
]
