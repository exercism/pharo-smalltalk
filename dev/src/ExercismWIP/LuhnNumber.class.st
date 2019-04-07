"
I represent a potential LuhnNumber.

I hold a string which could represent a valid Luhn number.
I know how to tell if the number I hold is a valid Luhn number.

I know how to print myself on a stream

Public API and Key Messages
- number:
- isValid

Create instances with the #from: class-side method

	(LunhNumber from: '59') isValid
 
Instance Variables
	number:		<String>

"
Class {
	#name : #LuhnNumber,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'ExercismWIP-Luhn'
}

{ #category : #'instance creation' }
LuhnNumber class >> from: aString [ 
	^ self new 
		number: aString;
		yourself 
]

{ #category : #accessing }
LuhnNumber >> number [
	^ number
]

{ #category : #accessing }
LuhnNumber >> number: aString [ 
	number := aString trimBoth
]
