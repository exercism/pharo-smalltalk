Class {
	#name : #Luhn,
	#superclass : #Object,
	#category : #'ExercismWIP-Luhn'
}

{ #category : #validating }
Luhn >> validValue: aString [
	| luhn |
	
	luhn := LuhnNumber from: aString.
	^ luhn isValid
]
