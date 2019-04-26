"
This is a sample solution for Exercism students.

Of interest, in this example is that classes can define instance methods with the same name, but taking different numbers of parameters.


"
Class {
	#name : #TwoFer,
	#superclass : #Object,
	#category : #'Exercism-TwoFer'
}

{ #category : #example }
TwoFer >> who [
	^ 'One for you, one for me.'
]

{ #category : #example }
TwoFer >> who: aString [ 
	^ 'One for ', aString, ', one for me.'
]
