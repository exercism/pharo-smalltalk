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
	^'828ee816-9d41-0d00-8ffd-5b4108866539'
]

{ #category : #config }
ComplexNumbersTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.3.0'
]

{ #category : #running }
ComplexNumbersTest >> setUp [
	super setUp.
	complexNumbersCalculator := ComplexNumbers new
]

{ #category : #tests }
ComplexNumbersTest >> test01_RealPartRealPartOfAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator realZ: #(1 0 ) .
	self assert: result equals: 1
]

{ #category : #tests }
ComplexNumbersTest >> test02_RealPartRealPartOfAPurelyImaginaryNumber [
	| result |

	result := complexNumbersCalculator realZ: #(0 1 ) .
	self assert: result equals: 0
]

{ #category : #tests }
ComplexNumbersTest >> test03_RealPartRealPartOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator realZ: #(1 2 ) .
	self assert: result equals: 1
]

{ #category : #tests }
ComplexNumbersTest >> test04_ImaginaryPartImaginaryPartOfAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator imaginaryZ: #(1 0 ) .
	self assert: result equals: 0
]

{ #category : #tests }
ComplexNumbersTest >> test05_ImaginaryPartImaginaryPartOfAPurelyImaginaryNumber [
	| result |

	result := complexNumbersCalculator imaginaryZ: #(0 1 ) .
	self assert: result equals: 1
]

{ #category : #tests }
ComplexNumbersTest >> test06_ImaginaryPartImaginaryPartOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator imaginaryZ: #(1 2 ) .
	self assert: result equals: 2
]

{ #category : #tests }
ComplexNumbersTest >> test07_ImaginaryUnit [
	| result |

	result := complexNumbersCalculator mulZ2: #(0 1 ) z1: #(0 1 ) .
	self assert: result equals: #( -1 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test08_ArithmeticAdditionAddPurelyRealNumbers [
	| result |

	result := complexNumbersCalculator addZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #(3 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test09_ArithmeticAdditionAddPurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator addZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #(0 3 )
]

{ #category : #tests }
ComplexNumbersTest >> test10_ArithmeticAdditionAddNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator addZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #(4 6 )
]

{ #category : #tests }
ComplexNumbersTest >> test11_ArithmeticSubtractionSubtractPurelyRealNumbers [
	| result |

	result := complexNumbersCalculator subZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #( -1 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test12_ArithmeticSubtractionSubtractPurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator subZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #(0  -1 )
]

{ #category : #tests }
ComplexNumbersTest >> test13_ArithmeticSubtractionSubtractNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator subZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #( -2  -2 )
]

{ #category : #tests }
ComplexNumbersTest >> test14_ArithmeticMultiplicationMultiplyPurelyRealNumbers [
	| result |

	result := complexNumbersCalculator mulZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #(2 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test15_ArithmeticMultiplicationMultiplyPurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator mulZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #( -2 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test16_ArithmeticMultiplicationMultiplyNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator mulZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #( -5 10 )
]

{ #category : #tests }
ComplexNumbersTest >> test17_ArithmeticDivisionDividePurelyRealNumbers [
	| result |

	result := complexNumbersCalculator divZ2: #(2 0 ) z1: #(1 0 ) .
	self assert: result equals: #(0.5 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test18_ArithmeticDivisionDividePurelyImaginaryNumbers [
	| result |

	result := complexNumbersCalculator divZ2: #(0 2 ) z1: #(0 1 ) .
	self assert: result equals: #(0.5 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test19_ArithmeticDivisionDivideNumbersWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator divZ2: #(3 4 ) z1: #(1 2 ) .
	self assert: result equals: #(0.44 0.08 )
]

{ #category : #tests }
ComplexNumbersTest >> test20_AbsoluteValueAbsoluteValueOfAPositivePurelyRealNumber [
	| result |

	result := complexNumbersCalculator absZ: #(5 0 ) .
	self assert: result equals: 5
]

{ #category : #tests }
ComplexNumbersTest >> test21_AbsoluteValueAbsoluteValueOfANegativePurelyRealNumber [
	| result |

	result := complexNumbersCalculator absZ: #( -5 0 ) .
	self assert: result equals: 5
]

{ #category : #tests }
ComplexNumbersTest >> test22_AbsoluteValueAbsoluteValueOfAPurelyImaginaryNumberWithPositiveImaginaryPart [
	| result |

	result := complexNumbersCalculator absZ: #(0 5 ) .
	self assert: result equals: 5
]

{ #category : #tests }
ComplexNumbersTest >> test23_AbsoluteValueAbsoluteValueOfAPurelyImaginaryNumberWithNegativeImaginaryPart [
	| result |

	result := complexNumbersCalculator absZ: #(0  -5 ) .
	self assert: result equals: 5
]

{ #category : #tests }
ComplexNumbersTest >> test24_AbsoluteValueAbsoluteValueOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator absZ: #(3 4 ) .
	self assert: result equals: 5
]

{ #category : #tests }
ComplexNumbersTest >> test25_ComplexConjugateConjugateAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator conjugateZ: #(5 0 ) .
	self assert: result equals: #(5 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test26_ComplexConjugateConjugateAPurelyImaginaryNumber [
	| result |

	result := complexNumbersCalculator conjugateZ: #(0 5 ) .
	self assert: result equals: #(0  -5 )
]

{ #category : #tests }
ComplexNumbersTest >> test27_ComplexConjugateConjugateANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator conjugateZ: #(1 1 ) .
	self assert: result equals: #(1  -1 )
]

{ #category : #tests }
ComplexNumbersTest >> test28_ComplexExponentialFunctionEulersIdentityformula [
	| result |

	result := complexNumbersCalculator expZ: #(0 'pi' ) .
	self assert: result equals: #( -1 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test29_ComplexExponentialFunctionExponentialOf0 [
	| result |

	result := complexNumbersCalculator expZ: #(0 0 ) .
	self assert: result equals: #(1 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test30_ComplexExponentialFunctionExponentialOfAPurelyRealNumber [
	| result |

	result := complexNumbersCalculator expZ: #(1 0 ) .
	self assert: result equals: #('e' 0 )
]

{ #category : #tests }
ComplexNumbersTest >> test31_ComplexExponentialFunctionExponentialOfANumberWithRealAndImaginaryPart [
	| result |

	result := complexNumbersCalculator expZ: #('ln(2)' 'pi' ) .
	self assert: result equals: #( -2 0 )
]
