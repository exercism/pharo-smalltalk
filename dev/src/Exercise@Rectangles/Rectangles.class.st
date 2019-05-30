"
Mentor notes:

- this solution identifies potential rectangles, by searching for + corners in a matrix, and then checking if those rectangles actually have lines joining the corners
- this is slightly brute force (although invalid rectangles are discounted before the final line checking)
- this solution had to use a new Region object, as Rectangles optimise their coordinates
"
Class {
	#name : #Rectangles,
	#superclass : #Object,
	#category : #'Exercise@Rectangles'
}

{ #category : #exercism }
Rectangles >> possibleRectangleRegionsIn: matrix [
	"Answer all possible Regions in the matrix, where there could be a rectangle"
	
	| corners |
	
	corners := (matrix
		indicesCollect: [ :r :c | 
			(matrix at: r at: c) = $+
				ifTrue: [ r @ c ]
				ifFalse: [ nil ] ]) asArray reject: [ :p | p isNil ].

	^ corners
		inject: Set new
		into: [ :result :corner | 
			| lowerCorners |
			lowerCorners := corners
				reject: [ :item | item = corner | (item x < corner x) | (item y < corner y) ].

			result
				addAll:
					(lowerCorners
						collect: [ :lc | corner region: lc ]
						thenSelect: [ :region | region isValid ]);
				yourself ]
]

{ #category : #exercism }
Rectangles >> rectanglesStrings: aCollection [
	| matrix |
	
	aCollection ifEmpty: [ ^ 0 ].
	
	matrix := Array2D
		rows: aCollection size
		columns: aCollection first size
		contents: (aCollection flatCollect: [ :c | c ]).
		
	^(self possibleRectangleRegionsIn: matrix) count: [ :region | 
		region definesRectangleIn: matrix ]
		
]
