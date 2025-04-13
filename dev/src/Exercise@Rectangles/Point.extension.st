Extension { #name : 'Point' }

{ #category : '*Exercise@Rectangles' }
Point >> region: aPoint [ 
	"Answer a Region that encompasses the receiver and aPoint."

	^ Region 
		topLeft: self
		bottomRight: aPoint
]
