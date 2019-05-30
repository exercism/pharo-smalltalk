Extension { #name : #LineSegment }

{ #category : #'*Exercise@Rectangles' }
LineSegment >> isHorizontal [
	^self start x = self end x
]

{ #category : #'*Exercise@Rectangles' }
LineSegment >> points [
	^self isHorizontal ifTrue: [ (self start y to: self end y) collect: [ :y | (self start x)@y ] ] ifFalse: [ (self start x to: self end x) collect: [ :x | x@(self start y )]]
]
