Class {
	#name : #Gigasecond,
	#superclass : #Object,
	#category : #'Exercism-Gigasecond'
}

{ #category : #accessing }
Gigasecond class >> gigaSecond [
^ 1000000000
]

{ #category : #adding }
Gigasecond >> addMoment: aString [
	^ String
		streamContents: [ :stream | 
			aString asDateAndTime + self class gigaSecond
				printISODateAndTimeOn: stream ]
]
