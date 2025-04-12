Extension { #name : 'LineSegment' }

{ #category : '*Exercise@Rectangles' }
LineSegment >> isRow [
	"Answer true if the segment is on the same row (the internal point x@y is storing row@col)"
	
	^self start x = self end x
]

{ #category : '*Exercise@Rectangles' }
LineSegment >> points [
	"Answer the points either along the same row, or the same column"
	
	^ self isRow
		ifTrue: [ (self start y to: self end y) collect: [ :y | self start x @ y ] ]
		ifFalse: [ (self start x to: self end x) collect: [ :x | x @ self start y ] ]
]
