"
# Complex Numbers

A complex number is a number in the form `a + b * i` where `a` and `b` are real and `i` satisfies `i^2 = -1`.

`a` is called the real part and `b` is called the imaginary part of `z`.
The conjugate of the number `a + b * i` is the number `a - b * i`.
The absolute value of a complex number `z = a + b * i` is a real number `|z| = sqrt(a^2 + b^2)`. The square of the absolute value `|z|^2` is the result of multiplication of `z` by its complex conjugate.

The sum/difference of two complex numbers involves adding/subtracting their real and imaginary parts separately:
`(a + i * b) + (c + i * d) = (a + c) + (b + d) * i`,
`(a + i * b) - (c + i * d) = (a - c) + (b - d) * i`.

Multiplication result is by definition
`(a + i * b) * (c + i * d) = (a * c - b * d) + (b * c + a * d) * i`.

The reciprocal of a non-zero complex number is
`1 / (a + i * b) = a/(a^2 + b^2) - b/(a^2 + b^2) * i`.

Dividing a complex number `a + i * b` by another `c + i * d` gives:
`(a + i * b) / (c + i * d) = (a * c + b * d)/(c^2 + d^2) + (b * c - a * d)/(c^2 + d^2) * i`.

Raising e to a complex exponent can be expressed as `e^(a + i * b) = e^a * e^(i * b)`, the last term of which is given by Euler's formula `e^(i * b) = cos(b) + i * sin(b)`.

Implement the following operations:
 - addition, subtraction, multiplication and division of two complex numbers,
 - conjugate, absolute value, exponent of a given complex number.


Assume the programming language you are using does not have an implementation of complex numbers.

## Hint

TBD

"
Class {
	#name : #ComplexNumbersTest,
	#superclass : #ExercismTest,
	#instVars : [
		'complexNumbersCalculator'
	],
	#category : #'ExercismWIP-ComplexNumbers'
}

{ #category : #config }
ComplexNumbersTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d9021bda-2b3f-0d00-a2f2-73e309f0590c'
]

{ #category : #config }
ComplexNumbersTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.3.0'
]

{ #category : #setup }
ComplexNumbersTest >> setUp [
	complexNumbersCalculator := ComplexNumbers new
]

{ #category : #test }
ComplexNumbersTest >> testAbsoluteValueAbsoluteValueOfANegativePurelyRealNumber [
	| result |

	result := complexNumbersCalculator absZ: #( -5 0 ) .
	self assert: result equals: 5
]

{ #category : #test }
ComplexNumbersTest >> testAbsoluteValueAbsoluteValueOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator absZ: #(3 4 ) .
	self assert: result equals: 5
]

{ #category : #test }
ComplexNumbersTest >> testAbsoluteValueAbsoluteValueOfAPositivePurelyRealNumber [
	| result |

	result := complexNumbersCalculator absZ: #(5 0 ) .
	self assert: result equals: 5
]

{ #category : #test }
ComplexNumbersTest >> testAbsoluteValueAbsoluteValueOfAPurelyImaginaryNumberWithNegativeImaginaryPart [
	| result |

	result := complexNumbersCalculator absZ: #(0  -5 ) .
	self assert: result equals: 5
]

{ #category : #test }
ComplexNumbersTest >> testAbsoluteValueAbsoluteValueOfAPurelyImaginaryNumberWithPositiveImaginaryPart [
	| result |

	result := complexNumbersCalculator absZ: #(0 5 ) .
	self assert: result equals: 5
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticAdditionAddNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator addZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #(4 6 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticAdditionAddPurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator addZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #(0 3 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticAdditionAddPurelyRealNumbers [
	| result |

	result := complexNumbersCalculator addZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #(3 0 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticDivisionDivideNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator divZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #(0.44 0.08 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticDivisionDividePurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator divZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #(0.5 0 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticDivisionDividePurelyRealNumbers [
	| result |

	result := complexNumbersCalculator divZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #(0.5 0 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticMultiplicationMultiplyNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator mulZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #( -5 10 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticMultiplicationMultiplyPurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator mulZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #( -2 0 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticMultiplicationMultiplyPurelyRealNumbers [
	| result |

	result := complexNumbersCalculator mulZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #(2 0 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticSubtractionSubtractNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator subZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #( -2  -2 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticSubtractionSubtractPurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator subZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #(0  -1 )
]

{ #category : #test }
ComplexNumbersTest >> testArithmeticSubtractionSubtractPurelyRealNumbers [
	| result |

	result := complexNumbersCalculator subZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #( -1 0 )
]

{ #category : #test }
ComplexNumbersTest >> testComplexConjugateConjugateANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator conjugateZ: #(1 1 ) .
	self assert: result equals: #(1  -1 )
]

{ #category : #test }
ComplexNumbersTest >> testComplexConjugateConjugateAPurelyImaginaryNumber [
	| result |

	result := complexNumbersCalculator conjugateZ: #(0 5 ) .
	self assert: result equals: #(0  -5 )
]

{ #category : #test }
ComplexNumbersTest >> testComplexConjugateConjugateAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator conjugateZ: #(5 0 ) .
	self assert: result equals: #(5 0 )
]

{ #category : #test }
ComplexNumbersTest >> testComplexExponentialFunctionEulersIdentityformula [
	| result |

	result := complexNumbersCalculator expZ: #(0 'pi' ) .
	self assert: result equals: #( -1 0 )
]

{ #category : #test }
ComplexNumbersTest >> testComplexExponentialFunctionExponentialOf0 [
	| result |

	result := complexNumbersCalculator expZ: #(0 0 ) .
	self assert: result equals: #(1 0 )
]

{ #category : #test }
ComplexNumbersTest >> testComplexExponentialFunctionExponentialOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator expZ: #('ln(2)' 'pi' ) .
	self assert: result equals: #( -2 0 )
]

{ #category : #test }
ComplexNumbersTest >> testComplexExponentialFunctionExponentialOfAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator expZ: #(1 0 ) .
	self assert: result equals: #('e' 0 )
]

{ #category : #test }
ComplexNumbersTest >> testImaginaryPartImaginaryPartOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator imaginaryZ: #(1 2 ) .
	self assert: result equals: 2
]

{ #category : #test }
ComplexNumbersTest >> testImaginaryPartImaginaryPartOfAPurelyImaginaryNumber [
	| result |

	result := complexNumbersCalculator imaginaryZ: #(0 1 ) .
	self assert: result equals: 1
]

{ #category : #test }
ComplexNumbersTest >> testImaginaryPartImaginaryPartOfAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator imaginaryZ: #(1 0 ) .
	self assert: result equals: 0
]

{ #category : #test }
ComplexNumbersTest >> testImaginaryUnit [
	| result |

	result := complexNumbersCalculator mulZ2: #(0 1 ) z1: #(0 1 ) .
	self assert: result equals: #( -1 0 )
]

{ #category : #test }
ComplexNumbersTest >> testRealPartRealPartOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator realZ: #(1 2 ) .
	self assert: result equals: 1
]

{ #category : #test }
ComplexNumbersTest >> testRealPartRealPartOfAPurelyImaginaryNumber [
	| result |

	result := complexNumbersCalculator realZ: #(0 1 ) .
	self assert: result equals: 0
]

{ #category : #test }
ComplexNumbersTest >> testRealPartRealPartOfAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator realZ: #(1 0 ) .
	self assert: result equals: 1
]
