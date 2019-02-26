"
This is a sample solution for Exercism students.

Of interest, in this example is that boolean operations like and: and or: are implemented as message sends on bolean objects. You can even browse their implementations - lookup 'and:' in the gtSpotter.
"
Class {
	#name : #Leap,
	#superclass : #Object,
	#category : #'Exercism-Leap'
}

{ #category : #example }
Leap >> is: anInteger evenlyDivisibleBy: divisorInteger [
	^(anInteger \\ divisorInteger) = 0
]

{ #category : #exercism }
Leap >> leapYear: anInteger [
	^ (self is: anInteger evenlyDivisibleBy: 4)
		and: [ (self is: anInteger evenlyDivisibleBy: 400)
				or: [ (self is: anInteger evenlyDivisibleBy: 100) not ] ]
]
