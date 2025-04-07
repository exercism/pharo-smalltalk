Class {
	#name : 'OcrNumbers',
	#superclass : 'Object',
	#classVars : [
		'DigitsTable'
	],
	#category : 'Exercise@OcrNumbers',
	#package : 'Exercise@OcrNumbers'
}

{ #category : 'internal' }
OcrNumbers class >> digitsStringFrom: aString [
	"Read the digits 'comments' from aString, Answer an OrderedCollection of lines containing the digits segments"

	| input |
	input := ReadStream on: aString.
	(input match: 'characters:')
		ifTrue: [ input next ]
		ifFalse: [ self error: 'character marker not found!' ].

	^ OrderedCollection streamContents: [ :result |
		  [ input atEnd ] whileFalse: [
			  input next.
			  result nextPut: (input nextLine copyUpTo: $') ] ]
]

{ #category : 'accessing' }
OcrNumbers class >> digitsTable [
	
	^ DigitsTable
]

{ #category : 'instance creation' }
OcrNumbers class >> from: aString [ 
	
	self initializeDigitsTableFrom: aString.
	^ self new
]

{ #category : 'internal' }
OcrNumbers class >> imageSize [ 
	
	"Answer a Point, representing the size of an ascii-image digit. x is width, y is height"
	^3@4
]

{ #category : 'internal' }
OcrNumbers class >> initializeDigitsTableFrom: aString [ 
	"Initialise a Dictionary of crc values for each digit character, parsed from aString"
	
	DigitsTable
		ifNil: [ 
			DigitsTable := (self parseDigitMatricesFrom: aString)
				inject: Dictionary new
				into: [ :result :digitEntry | 
					result
						at: digitEntry value crc16 put: digitEntry key asCharacterDigit;
						yourself ] ]

]

{ #category : 'internal' }
OcrNumbers class >> parseDigitMatricesFrom: aString [ 
	
	"Parse aString as series of 3x4 digit ascii images, Answer a Collection or associations mapping the integer digit value, to a 2D Array of the image"
	| digitLines matrix digits numberOfDigits |
	
	numberOfDigits := 10.
	digitLines := (self digitsStringFrom: aString).
	
	matrix := Array2D
		rows: digitLines size
		columns: digitLines first size
		contents: ('' join: digitLines).
		
	digits := self split: matrix into: numberOfDigits by: 1.
		
	^ digits collectWithIndex: [ :dm :i | i % numberOfDigits -> dm ]

]

{ #category : 'internal' }
OcrNumbers class >> split: sourceMatrix into: width by: height [
	
	"Split a Matrix of an arbitrary number of 3x4 digit images, into a single OrderedCollection, ordered from left to rigth, top to bottom"
	| result sliceRow sliceCol imageWidth imageHeight |
	
	imageWidth := self imageSize x.
	imageHeight := self imageSize y.
	
	result := OrderedCollection new.

	1 to: height do: [ :h | 
		1 to: width do: [ :w | 
			sliceRow := (h - 1) * imageHeight + 1.
			sliceCol := (w - 1) * imageWidth + 1.

			result
				add:
					(sourceMatrix
						atRows: sliceRow
						to: sliceRow + imageHeight - 1
						columns: sliceCol
						to: sliceCol + imageWidth - 1) ] ].

	^ result
]

{ #category : 'exercism' }
OcrNumbers >> convertRows: aCollection [
	"As per exercise, convert aCollection of image line strings, into a string of numbers"
	
	| dimensions sourceMatrix digitMatrices horizontalGroups |
	
	dimensions := self verifyInput: aCollection.

	sourceMatrix := Array2D
		rows: dimensions y
		columns: dimensions x
		contents: ('' join:  aCollection).

	horizontalGroups := dimensions x / (self class imageSize x).
	
	digitMatrices := self class
		split: sourceMatrix
		into: horizontalGroups
		by: dimensions y / (self class imageSize y).

	^ String
		streamContents: [ :stream | 
			digitMatrices
				doWithIndex: [ :matrix :i | 
					(self shouldSplit: i in: horizontalGroups)
						ifTrue: [ stream nextPut: $, ].
					stream
						nextPut: (self class digitsTable at: matrix crc16 ifAbsent: [ $? ]) ] ]
]

{ #category : 'exercism' }
OcrNumbers >> shouldSplit: i in: totalGroups [ 
	
	"Answer true, if the i'th image should generate a $, in its output"
	^ i > 1 and: [ i - 1 isDivisibleBy: totalGroups ]
]

{ #category : 'exercism' }
OcrNumbers >> verifyInput: aCollection [

	aCollection size % 4 ~= 0
		ifTrue: [ self error: 'Number of input lines is not a multiple of four' ].
	aCollection first size % 3 ~= 0
		ifTrue: [ self error: 'Number of input columns is not a multiple of three' ].
		
	^(aCollection first size)@(aCollection size)
]
