"
If you spot the following useful methods in Integer, this solution is quite trivial:
- #decimalDigitLength
- #decimalDigitAt: 
"
Class {
	#name : 'ArmstrongNumbers',
	#superclass : 'Object',
	#category : 'Exercise@ArmstrongNumbers',
	#package : 'Exercise@ArmstrongNumbers'
}

{ #category : 'testing' }
ArmstrongNumbers >> isArmstrongNumber: anInteger [
	| armstrongValue decimalDigitLength |
	decimalDigitLength := anInteger decimalDigitLength.
	armstrongValue := ((1 to: decimalDigitLength)
		collect:
			[ :index | (anInteger decimalDigitAt: index) raisedTo: decimalDigitLength ])
		sumNumbers.
	^ anInteger = armstrongValue
]
