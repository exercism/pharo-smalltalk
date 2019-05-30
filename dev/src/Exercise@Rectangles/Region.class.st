"
I represent an x,y to x',y' region which is considered valid when x < x' and y < y'.

I can be created with invalid coordinates, but then be filtered by #isValid.
I also answer line segments for my sides.
"
Class {
	#name : #Region,
	#superclass : #Object,
	#instVars : [
		'topLeft',
		'bottomRight'
	],
	#category : #'Exercise@Rectangles'
}

{ #category : #'as yet unclassified' }
Region class >> topLeft: pt1 bottomRight: pt2 [
	^self new
		topLeft: pt1;
		bottomRight: pt2;
		yourself 
]

{ #category : #accessing }
Region >> bottomRight [
	^ bottomRight
]

{ #category : #accessing }
Region >> bottomRight: anObject [
	bottomRight := anObject
]

{ #category : #accessing }
Region >> definesRectangleIn: aMatrix [
	self sides do: [ :side | 
		(aMatrix isLineAt: side) ifFalse: [^false]].
	
	^true
]

{ #category : #accessing }
Region >> height [
	"Answer the height of the region, while a negative value is possible, it denotes an invalid region"
	
	^self bottomRight y - self topLeft y

]

{ #category : #accessing }
Region >> isValid [ 
	^self width > 0 and: [ self height > 0 ]
]

{ #category : #accessing }
Region >> printOn: aStream [ 
	"Refer to the comment in Object|printOn:."

	self topLeft printOn: aStream.
	aStream nextPutAll: ' to: '.
	self bottomRight printOn: aStream
]

{ #category : #accessing }
Region >> sides [
	self isValid
		ifFalse: [ ^ {} ].

	^ {
	(LineSegment
		from: self topLeft
		to: self topLeft + (self width @ 0)).
	(LineSegment
		from: self bottomRight - (self width @ 0)
		to: self bottomRight).
	(LineSegment 
		from: self topLeft 
		to: self topLeft + (0 @ self height)).
	(LineSegment
		from: self bottomRight - (0 @ self height)
		to: self bottomRight)}
]

{ #category : #accessing }
Region >> topLeft [
	^ topLeft
]

{ #category : #accessing }
Region >> topLeft: anObject [
	topLeft := anObject
]

{ #category : #accessing }
Region >> width [
	"Answer the width of the region, while a negative value is possible, it denotes an invalid region"
	
	^self bottomRight x - self topLeft x

]
