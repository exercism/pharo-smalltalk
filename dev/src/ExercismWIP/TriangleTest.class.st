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
	^'51fed216-9d41-0d00-8fed-03f808866539'
]

{ #category : #config }
TriangleTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.2.1'
]

{ #category : #setup }
TriangleTest >> setUp [
	triangleCalculator := Triangle new
]

{ #category : #tests }
TriangleTest >> test01_EquilateralTriangleAllSidesAreEqual [
	| result |

	result := triangleCalculator equilateralSides: #(2 2 2 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test02_EquilateralTriangleAnySideIsUnequal [
	| result |

	result := triangleCalculator equilateralSides: #(2 3 2 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test03_EquilateralTriangleNoSidesAreEqual [
	| result |

	result := triangleCalculator equilateralSides: #(5 4 6 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test04_EquilateralTriangleAllZeroSidesIsNotATriangle [
	| result |

	result := triangleCalculator equilateralSides: #(0 0 0 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test05_EquilateralTriangleSidesMayBeFloats [
	| result |

	result := triangleCalculator equilateralSides: #(0.5 0.5 0.5 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test06_IsoscelesTriangleLastTwoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(3 4 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test07_IsoscelesTriangleFirstTwoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(4 4 3 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test08_IsoscelesTriangleFirstAndLastSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(4 3 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test09_IsoscelesTriangleEquilateralTrianglesAreAlsoIsosceles [
	| result |

	result := triangleCalculator isoscelesSides: #(4 4 4 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test10_IsoscelesTriangleNoSidesAreEqual [
	| result |

	result := triangleCalculator isoscelesSides: #(2 3 4 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test11_IsoscelesTriangleFirstTriangleInequalityViolation [
	| result |

	result := triangleCalculator isoscelesSides: #(1 1 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test12_IsoscelesTriangleSecondTriangleInequalityViolation [
	| result |

	result := triangleCalculator isoscelesSides: #(1 3 1 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test13_IsoscelesTriangleThirdTriangleInequalityViolation [
	| result |

	result := triangleCalculator isoscelesSides: #(3 1 1 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test14_IsoscelesTriangleSidesMayBeFloats [
	| result |

	result := triangleCalculator isoscelesSides: #(0.5 0.4 0.5 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test15_ScaleneTriangleNoSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(5 4 6 ) .
	self assert: result equals: true
]

{ #category : #tests }
TriangleTest >> test16_ScaleneTriangleAllSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(4 4 4 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test17_ScaleneTriangleTwoSidesAreEqual [
	| result |

	result := triangleCalculator scaleneSides: #(4 4 3 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test18_ScaleneTriangleMayNotViolateTriangleInequality [
	| result |

	result := triangleCalculator scaleneSides: #(7 3 2 ) .
	self assert: result equals: false
]

{ #category : #tests }
TriangleTest >> test19_ScaleneTriangleSidesMayBeFloats [
	| result |

	result := triangleCalculator scaleneSides: #(0.5 0.4 0.6 ) .
	self assert: result equals: true
]
