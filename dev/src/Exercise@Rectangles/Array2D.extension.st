Extension { #name : #Array2D }

{ #category : #'*Exercise@Rectangles' }
Array2D >> isLineAt: aLineSegment [
	"Answer true, if a LineSegment identifies a valid line in my space. 
	Lines can be composed of +,-,| characters, anything else is invalid"
	
	| lineChars |
	
	lineChars := aLineSegment points
		collect: [ :point | self at: point x at: point y ]
		thenReject: [ :char | char = $+ ].

	^ (lineChars
		reject: [ :char | 
			char = 
				(aLineSegment isHorizontal
						ifTrue: [ $- ]
						ifFalse: [ $| ]) ]) ifEmpty: [ true ] ifNotEmpty: [ false ]
]
