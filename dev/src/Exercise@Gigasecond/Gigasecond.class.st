Class {
	#name : 'Gigasecond',
	#superclass : 'Object',
	#category : 'Exercise@Gigasecond',
	#package : 'Exercise@Gigasecond'
}

{ #category : 'accessing' }
Gigasecond class >> gigaSecond [

	^ 1000000000 asSeconds
]

{ #category : 'adding' }
Gigasecond >> addMoment: aString [

	^ String streamContents: [ :stream | 
			self
				print: aString asDateAndTime + self class gigaSecond
				asISODateAndTimeOn: stream 
	]
]

{ #category : 'printing' }
Gigasecond >> print: aDateAndTime asISODateAndTimeOn: stream [

	stream
		nextPutAll: aDateAndTime asDate yyyymmdd;
		nextPut: $T;
		nextPutAll: aDateAndTime asTime print24
]
