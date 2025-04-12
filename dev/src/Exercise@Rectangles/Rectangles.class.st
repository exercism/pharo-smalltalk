"
Mentor notes:

- this solution identifies potential rectangles, by searching for + corners in a matrix, deriving valid rectangle permuations from them, and then checking if those derived rectangles actually have lines joining the corners
- this solution had to use a new Region object, as Rectangles optimise their coordinates
"
Class {
	#name : 'Rectangles',
	#superclass : 'Object',
	#category : 'Exercise@Rectangles',
	#package : 'Exercise@Rectangles'
}

{ #category : 'helper' }
Rectangles >> getAllRectangleCornersIn: matrix [
	^ matrix
		withIndicesInject: OrderedCollection new
		into: [ :result :value :r :c | 
			value = $+
				ifTrue: [ result add: r @ c ].
			result ]
]

{ #category : 'helper' }
Rectangles >> possibleRectangleRegionsIn: matrix [
	"Answer all possible Regions in the matrix, where there could be a rectangle"

	| corners |
	corners := self getAllRectangleCornersIn: matrix.

	^ corners
		inject: Set new
		into: [ :result :corner | 
			| lowerCorners |
			
			lowerCorners := self potentialLowerCornersFor: corner given: corners.

			result
				addAll:
					(lowerCorners
						collect: [ :lc | corner region: lc ]
						thenSelect: [ :region | region isValid ]);
				yourself ]
]

{ #category : 'helper' }
Rectangles >> potentialLowerCornersFor: topLeftCorner given: corners [
	^ corners
		reject: [ :corner | 
			corner = topLeftCorner | (corner x < topLeftCorner x)
				| (corner y < topLeftCorner y) ]
]

{ #category : 'exercism' }
Rectangles >> rectanglesFromStrings: aCollection [
	"Answer the number of rectangles recognized in aCollection of Strings"
	
	| matrix |
	
	aCollection ifEmpty: [ ^ 0 ].
	
	matrix := Array2D
		rows: aCollection size
		columns: aCollection first size
		contents: (aCollection flatCollect: [ :c | c ]).
		
	^(self possibleRectangleRegionsIn: matrix) count: [ :region | 
		region definesRectangleIn: matrix ]
		
]
