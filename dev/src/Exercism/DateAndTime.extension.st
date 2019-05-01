Extension { #name : #DateAndTime }

{ #category : #'*Exercism' }
DateAndTime >> printISODateAndTimeOn: stream [
	stream
		nextPutAll: self asDate yyyymmdd;
		nextPut: $T;
		nextPutAll: self asTime print24
]
