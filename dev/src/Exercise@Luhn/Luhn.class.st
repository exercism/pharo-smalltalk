"
I adapt the LuhnTest to a more Smalltalk like LuhnNumber domain object.

"
Class {
	#name : 'Luhn',
	#superclass : 'Object',
	#category : 'Exercise@Luhn',
	#package : 'Exercise@Luhn'
}

{ #category : 'validating' }
Luhn >> validValue: aString [
	| luhn |
	
	luhn := LuhnNumber from: aString.
	^ luhn isValid
]
