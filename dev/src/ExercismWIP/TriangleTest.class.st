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
	^'992765be-4a3f-0d00-bb43-0ac8071d6982'
]

{ #category : #config }
TriangleTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.2.0'
]

{ #category : #setup }
TriangleTest >> setUp [
	triangleCalculator := Triangle new
]

{ #category : #tests }
TriangleTest >> test01_ReturnsTrueIfTheTriangleIsEquilateralTrueIfAllSidesAreEqual [
	| result |

	result := triangleCalculator equilateralSides: #(2 2 2 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test01_ReturnsTrueIfTheTriangleIsIsoscelesTrueIfLastTwoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(3 4 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test01_ReturnsTrueIfTheTriangleIsScaleneTrueIfNoSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(5 4 6 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test02_ReturnsTrueIfTheTriangleIsEquilateralFalseIfAnySideIsUnequal [
	| result |

	result := triangleCalculator equilateralSides: #(2 3 2 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test02_ReturnsTrueIfTheTriangleIsIsoscelesTrueIfFirstTwoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(4 4 3 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test02_ReturnsTrueIfTheTriangleIsScaleneFalseIfAllSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(4 4 4 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test03_ReturnsTrueIfTheTriangleIsEquilateralFalseIfNoSidesAreEqual [
	| result |

	result := triangleCalculator equilateralSides: #(5 4 6 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test03_ReturnsTrueIfTheTriangleIsIsoscelesTrueIfFirstAndLastSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(4 3 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test03_ReturnsTrueIfTheTriangleIsScaleneFalseIfTwoSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(4 4 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test04_ReturnsTrueIfTheTriangleIsEquilateralAllZeroSidesAreIllegalSoTheTriangleIsNotEquilateral [
	| result |

	result := triangleCalculator equilateralSides: #(0 0 0 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test04_ReturnsTrueIfTheTriangleIsIsoscelesEquilateralTrianglesAreAlsoIsosceles [
	| result |

	result := triangleCalculator isoscelesSides: #(4 4 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test04_ReturnsTrueIfTheTriangleIsScaleneSidesThatViolateTriangleInequalityAreNotScaleneEvenIfTheyAreAllDifferent [
	| result |

	result := triangleCalculator scaleneSides: #(7 3 2 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test05_ReturnsTrueIfTheTriangleIsEquilateralSidesMayBeFloats [
	| result |

	result := triangleCalculator equilateralSides: #(0.5 0.5 0.5 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test05_ReturnsTrueIfTheTriangleIsIsoscelesFalseIfNoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(2 3 4 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test05_ReturnsTrueIfTheTriangleIsScaleneSidesMayBeFloats [
	| result |

	result := triangleCalculator scaleneSides: #(0.5 0.4 0.6 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test06_ReturnsTrueIfTheTriangleIsIsoscelesSidesThatViolateTriangleInequalityAreNotIsoscelesEvenIfTwoAreEqual1 [
	| result |

	result := triangleCalculator isoscelesSides: #(1 1 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test07_ReturnsTrueIfTheTriangleIsIsoscelesSidesThatViolateTriangleInequalityAreNotIsoscelesEvenIfTwoAreEqual2 [
	| result |

	result := triangleCalculator isoscelesSides: #(1 3 1 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test08_ReturnsTrueIfTheTriangleIsIsoscelesSidesThatViolateTriangleInequalityAreNotIsoscelesEvenIfTwoAreEqual3 [
	| result |

	result := triangleCalculator isoscelesSides: #(3 1 1 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test09_ReturnsTrueIfTheTriangleIsIsoscelesSidesMayBeFloats [
	| result |

	result := triangleCalculator isoscelesSides: #(0.5 0.4 0.5 ) .
	self assert: result equals: true
]
