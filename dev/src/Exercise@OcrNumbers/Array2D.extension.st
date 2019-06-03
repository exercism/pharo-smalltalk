Extension { #name : #Array2D }

{ #category : #'*Exercise@OcrNumbers' }
Array2D >> crc16 [
	^CRC crc16FromCollection: (self asArray collect: [ :c | c asciiValue ])
]
