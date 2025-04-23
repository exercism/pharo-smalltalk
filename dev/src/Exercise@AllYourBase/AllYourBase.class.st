Class {
	#name : 'AllYourBase',
	#superclass : 'Object',
	#category : 'Exercise@AllYourBase',
	#package : 'Exercise@AllYourBase'
}

{ #category : 'exercism' }
AllYourBase >> convertDecimal: aDecimal outputBase: outputBase [

	|remainder division resultDigits|
	outputBase >= 2 ifFalse: [Error signal: 'output base must be >= 2' ].
	resultDigits := OrderedCollection new.
	division := aDecimal.
	[  
		remainder := division \\ outputBase.
		division := division // outputBase.
		resultDigits addFirst: remainder.
	] doWhileFalse: [ division isZero ].
	^ resultDigits asArray
]

{ #category : 'exercism' }
AllYourBase >> convertToDecimal: digitsArray fromBase: inputBase [
	
	^ (digitsArray reversed withIndexCollect: [ 
		:digit :i | 
		(digit >= 0 and: [digit < inputBase]) 
		ifFalse: [ Error signal: 'all digits must satisfy 0 <= d < input base' ].
		digit * (inputBase raisedTo: i - 1) 
		]) sumNumbers
]

{ #category : 'exercism' }
AllYourBase >> rebaseInputBase: inputBase digits: digitsArray outputBase: outputBase [

	|aDecimal|
	inputBase >= 2 ifFalse: [Error signal: 'input base must be >= 2' ].
	aDecimal := self convertToDecimal: digitsArray fromBase: inputBase.
	^ self convertDecimal: aDecimal outputBase: outputBase
]
