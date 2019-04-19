Class {
	#name : #ArmstrongNumbers,
	#superclass : #Object,
	#category : #'Exercism-ArmstrongNumbers'
}

{ #category : #testing }
ArmstrongNumbers >> isArmstrongNumber: anInteger [
	| armstrongValue decimalDigitLength |
	decimalDigitLength := anInteger decimalDigitLength.
	armstrongValue := ((1 to: decimalDigitLength)
		collect:
			[ :index | (anInteger decimalDigitAt: index) raisedTo: decimalDigitLength ])
		sumNumbers.
	^ anInteger = armstrongValue
]
