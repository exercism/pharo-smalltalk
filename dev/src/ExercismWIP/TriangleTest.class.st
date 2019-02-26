"
# Triangle

Determine if a triangle is equilateral, isosceles, or scalene.

An _equilateral_ triangle has all three sides the same length.

An _isosceles_ triangle has at least two sides the same length. (It is sometimes
specified as having exactly two sides the same length, but for the purposes of
this exercise we'll say at least two.)

A _scalene_ triangle has all sides of different lengths.

## Note

For a shape to be a triangle at all, all sides have to be of length > 0, and
the sum of the lengths of any two sides must be greater than or equal to the
length of the third side. See [Triangle Inequality](https://en.wikipedia.org/wiki/Triangle_inequality).

## Dig Deeper

The case where the sum of the lengths of two sides _equals_ that of the
third is known as a _degenerate_ triangle - it has zero area and looks like
a single line. Feel free to add your own code/tests to check for degenerate triangles.

## Hint

TBD

"
Class {
	#name : #TriangleTest,
	#superclass : #ExercismTest,
	#instVars : [
		'triangleCalculator'
	],
	#category : #'ExercismWIP-Triangle'
}

{ #category : #config }
TriangleTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d91505da-2b3f-0d00-a2df-f62a09f0590c'
]

{ #category : #config }
TriangleTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
TriangleTest >> setUp [
	triangleCalculator := Triangle new
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsEquilateralAllZeroSidesAreIllegalSoTheTriangleIsNotEquilateral [
	| result |

	result := triangleCalculator equilateralSides: #(0 0 0 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsEquilateralFalseIfAnySideIsUnequal [
	| result |

	result := triangleCalculator equilateralSides: #(2 3 2 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsEquilateralFalseIfNoSidesAreEqual [
	| result |

	result := triangleCalculator equilateralSides: #(5 4 6 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsEquilateralSidesMayBeFloats [
	| result |

	result := triangleCalculator equilateralSides: #(0.5 0.5 0.5 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsEquilateralTrueIfAllSidesAreEqual [
	| result |

	result := triangleCalculator equilateralSides: #(2 2 2 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesEquilateralTrianglesAreAlsoIsosceles [
	| result |

	result := triangleCalculator isoscelesSides: #(4 4 4 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesFalseIfNoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(2 3 4 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesSidesMayBeFloats [
	| result |

	result := triangleCalculator isoscelesSides: #(0.5 0.4 0.5 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesSidesThatViolateTriangleInequalityAreNotIsoscelesEvenIfTwoAreEqual1 [
	| result |

	result := triangleCalculator isoscelesSides: #(1 1 3 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesSidesThatViolateTriangleInequalityAreNotIsoscelesEvenIfTwoAreEqual2 [
	| result |

	result := triangleCalculator isoscelesSides: #(1 3 1 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesSidesThatViolateTriangleInequalityAreNotIsoscelesEvenIfTwoAreEqual3 [
	| result |

	result := triangleCalculator isoscelesSides: #(3 1 1 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesTrueIfFirstAndLastSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(4 3 4 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesTrueIfFirstTwoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(4 4 3 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsIsoscelesTrueIfLastTwoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(3 4 4 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsScaleneFalseIfAllSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(4 4 4 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsScaleneFalseIfTwoSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(4 4 3 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsScaleneSidesMayBeFloats [
	| result |

	result := triangleCalculator scaleneSides: #(0.5 0.4 0.6 ) .
	self assert: result equals: true
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsScaleneSidesThatViolateTriangleInequalityAreNotScaleneEvenIfTheyAreAllDifferent [
	| result |

	result := triangleCalculator scaleneSides: #(7 3 2 ) .
	self assert: result equals: false
]

{ #category : #test }
TriangleTest >> testReturnsTrueIfTheTriangleIsScaleneTrueIfNoSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(5 4 6 ) .
	self assert: result equals: true
]
