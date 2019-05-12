"
This is pretty starightforward once you spot how Pharo handles a while loop.
"
Class {
	#name : #RomanNumerals,
	#superclass : #Object,
	#classVars : [
		'NumeralsTable'
	],
	#category : #'Exercise@RomanNumerals'
}

{ #category : #constants }
RomanNumerals class >> numeralsTable [
	"Answer a table of arabic to roman numeral conversions."
	
	^ NumeralsTable
		ifNil: [ 
			NumeralsTable := {
			(1000 -> 'M').
			(900 -> 'CM').
			(500 -> 'D').
			(400 -> 'CD').
			(100 -> 'C').
			(90 -> 'XC').
			(50 -> 'L').
			(40 -> 'XL').
			(10 -> 'X').
			(9 -> 'IX').
			(5 -> 'V').
			(4 -> 'IV').
			(1 -> 'I')} asOrderedDictionary ]
]

{ #category : #exercism }
RomanNumerals >> romanNumber: anInteger [
	| number |
	
	number := anInteger.
	
	^ String
		streamContents: [ :s | 	
			self class numeralsTable keysAndValuesDo: [ :arabic :roman | 
				[ number >= arabic ] whileTrue: [ 
						s << roman.
						number := number - arabic ] ] ]
]
