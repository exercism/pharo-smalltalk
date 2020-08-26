Class {
	#name : #Sieve2,
	#superclass : #Object,
	#category : #'Exercise@Sieve'
}

{ #category : #exercism }
Sieve2 >> primesLimit: anInteger [ 
  | primes marks |
primes := Stack new.
  marks := Array new: anInteger.
  marks at: 1 put: #notPrime.
  marks doWithIndex: [ :mark :number |
    mark ifNil: [ 
      primes push: number.
      number to: anInteger by: number do: [ :notPrime | 
        marks at: notPrime put: #notPrime ] ] ].
  ^ primes reversed 

]
