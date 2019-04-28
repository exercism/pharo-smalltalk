"
This solution demonstrates the use of a while loop in Pharo. Notice how while is is simply a message send to a BlockClosure and involves no special syntax to achieve this.
"
Class {
	#name : #Sieve,
	#superclass : #Object,
	#category : #'Exercism@Sieve'
}

{ #category : #helper }
Sieve >> nonPrimesFor: anInteger in: markedList [
	^(markedList select: [ :i | i \\ anInteger = 0 ])

	
]

{ #category : #exercism }
Sieve >> primesLimit: anInteger [
	"Answer the Array of primes up to anInteger"
	
	| markedList primes |

	markedList := OrderedCollection withAll: (2 to: anInteger).
	primes := OrderedCollection new.
	
	[ markedList notEmpty ] whileTrue: [	| nextPrime |
			primes add: (nextPrime := markedList removeFirst).
			markedList removeAll: (self nonPrimesFor: nextPrime in: markedList) ].
		
	^ primes asArray
]
