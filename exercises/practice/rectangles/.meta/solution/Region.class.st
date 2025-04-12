"
I represent an x,y to x',y' region which is considered valid when x < x' and y < y'.

I can be created with invalid coordinates, but then be filtered by #isValid.
I also answer line segments for my sides.
"
Class {
	#name : 'Region',
	#superclass : 'Object',
	#instVars : [
		'topLeft',
		'bottomRight'
	],
	#category : 'Exercise@Rectangles',
	#package : 'Exercise@Rectangles'
}

{ #category : 'as yet unclassified' }
Region class >> topLeft: pt1 bottomRight: pt2 [
	^self new
		topLeft: pt1;
		bottomRight: pt2;
		yourself 
]

{ #category : 'accessing' }
Region >> bottomRight [
	^ bottomRight
]

{ #category : 'accessing' }
Region >> bottomRight: aPoint [
	bottomRight := aPoint
]

{ #category : 'accessing' }
Region >> definesRectangleIn: aMatrix [
	^ self sides allSatisfy: [ :side | aMatrix isLineAt: side ]
]

{ #category : 'accessing' }
Region >> height [
	"Answer the height of the region, while a negative value is possible, it denotes an invalid region"
	
	^self bottomRight y - self topLeft y

]

{ #category : 'accessing' }
Region >> isValid [ 
	^self width > 0 and: [ self height > 0 ]
]

{ #category : 'printing' }
Region >> printOn: aStream [ 
	"Refer to the comment in Object|printOn:."

	self topLeft printOn: aStream.
	aStream nextPutAll: ' to: '.
	self bottomRight printOn: aStream
]

{ #category : 'accessing' }
Region >> sides [
	| regionWidth regionHeight |
	
	self isValid
		ifFalse: [ ^ {} ].
		
	regionWidth := (self width) @ 0.
	regionHeight := 0 @ (self height).

	^ {
	(LineSegment 
		from: self topLeft 
		to: self topLeft + regionWidth).
	(LineSegment
		from: self bottomRight - regionWidth
		to: self bottomRight).
	(LineSegment 
		from: self topLeft 
		to: self topLeft + regionHeight).
	(LineSegment
		from: self bottomRight - regionHeight
		to: self bottomRight)}
]

{ #category : 'accessing' }
Region >> topLeft [
	^ topLeft
]

{ #category : 'accessing' }
Region >> topLeft: aPoint [
	topLeft := aPoint
]

{ #category : 'accessing' }
Region >> width [
	"Answer the width of the region, while a negative value is possible, it denotes an invalid region"
	
	^self bottomRight x - self topLeft x

]
