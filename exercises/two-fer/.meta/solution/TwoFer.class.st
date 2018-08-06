"
This is a sample solution for Exercism students.

Of interest, in this example is that classes can define instance methods with the same name, but taking different numbers of parameters.

A method which has no parameters, is called a unary method, and a method taking multiple parameters, each deliniated by a word ending with a ':', is called a keyword method.

There is also a third type of method, binary, which takes only 1 parameter but uses a symbol(s) for a name (typically a mathematical one like: +, -, & etc).
"
Class {
	#name : #TwoFer,
	#superclass : #Object,
	#category : #'Exercism-TwoFer'
}

{ #category : #exercism }
TwoFer >> who [
	^ 'One for you, one for me.'
]

{ #category : #exercism }
TwoFer >> who: aString [ 
	^ 'One for ', aString, ', one for me.'
]
