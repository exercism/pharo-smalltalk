"
# Rational Numbers

A rational number is defined as the quotient of two integers `a` and `b`, called the numerator and denominator, respectively, where `b != 0`.

The absolute value `|r|` of the rational number `r = a/b` is equal to `|a|/|b|`.

The sum of two rational numbers `r1 = a1/b1` and `r2 = a2/b2` is `r1 + r2 = a1/b1 + a2/b2 = (a1 * b2 + a2 * b1) / (b1 * b2)`.

The difference of two rational numbers `r1 = a1/b1` and `r2 = a2/b2` is `r1 - r2 = a1/b1 - a2/b2 = (a1 * b2 - a2 * b1) / (b1 * b2)`.

The product (multiplication) of two rational numbers `r1 = a1/b1` and `r2 = a2/b2` is `r1 * r2 = (a1 * a2) / (b1 * b2)`.

Dividing a rational number `r1 = a1/b1` by another `r2 = a2/b2` is `r1 / r2 = (a1 * b2) / (a2 * b1)` if `a2 * b1` is not zero.

Exponentiation of a rational number `r = a/b` to a non-negative integer power `n` is `r^n = (a^n)/(b^n)`.

Exponentiation of a rational number `r = a/b` to a negative integer power `n` is `r^n = (b^m)/(a^m)`, where `m = |n|`.

Exponentiation of a rational number `r = a/b` to a real (floating-point) number `x` is the quotient `(a^x)/(b^x)`, which is a real number.

Exponentiation of a real number `x` to a rational number `r = a/b` is `x^(a/b) = root(x^a, b)`, where `root(p, q)` is the `q`th root of `p`.

Implement the following operations:
 - addition, subtraction, multiplication and division of two rational numbers,
 - absolute value, exponentiation of a given rational number to an integer power, exponentiation of a given rational number to a real (floating-point) power, exponentiation of a real number to a rational number.

Your implementation of rational numbers should always be reduced to lowest terms. For example, `4/4` should reduce to `1/1`, `30/60` should reduce to `1/2`, `12/8` should reduce to `3/2`, etc. To reduce a rational number `r = a/b`, divide `a` and `b` by the greatest common divisor (gcd) of `a` and `b`. So, for example, `gcd(12, 8) = 4`, so `r = 12/8` can be reduced to `(12/4)/(8/4) = 3/2`.

Assume that the programming language you are using does not have an implementation of rational numbers.

## Hint

TBD

"
Class {
	#name : #RationalNumbersTest,
	#superclass : #ExercismTest,
	#instVars : [
		'rationalNumbersCalculator'
	],
	#category : #'ExercismWIP-RationalNumbers'
}

{ #category : #config }
RationalNumbersTest class >> uuid [
	"Answer a unique id for this exercise"
	^'efb50cda-2b3f-0d00-a2e5-22a209f0590c'
]

{ #category : #config }
RationalNumbersTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
RationalNumbersTest >> setUp [
	rationalNumbersCalculator := RationalNumbers new
]

{ #category : #test }
RationalNumbersTest >> testAbsoluteValueAbsoluteValueOfANegativeRationalNumber [
	| result |

	result := rationalNumbersCalculator absR: #( -1 2 ) .
	self assert: result equals: #(1 2 )
]

{ #category : #test }
RationalNumbersTest >> testAbsoluteValueAbsoluteValueOfAPositiveRationalNumber [
	| result |

	result := rationalNumbersCalculator absR: #(1 2 ) .
	self assert: result equals: #(1 2 )
]

{ #category : #test }
RationalNumbersTest >> testAbsoluteValueAbsoluteValueOfZero [
	| result |

	result := rationalNumbersCalculator absR: #(0 1 ) .
	self assert: result equals: #(0 1 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticAdditionAddAPositiveRationalNumberAndANegativeRationalNumber [
	| result |

	result := rationalNumbersCalculator addR1: #(1 2 ) r2: #( -2 3 ) .
	self assert: result equals: #( -1 6 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticAdditionAddARationalNumberToItsAdditiveInverse [
	| result |

	result := rationalNumbersCalculator addR1: #(1 2 ) r2: #( -1 2 ) .
	self assert: result equals: #(0 1 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticAdditionAddTwoNegativeRationalNumbers [
	| result |

	result := rationalNumbersCalculator addR1: #( -1 2 ) r2: #( -2 3 ) .
	self assert: result equals: #( -7 6 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticAdditionAddTwoPositiveRationalNumbers [
	| result |

	result := rationalNumbersCalculator addR1: #(1 2 ) r2: #(2 3 ) .
	self assert: result equals: #(7 6 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticDivisionDivideAPositiveRationalNumberByANegativeRationalNumber [
	| result |

	result := rationalNumbersCalculator divR1: #(1 2 ) r2: #( -2 3 ) .
	self assert: result equals: #( -3 4 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticDivisionDivideARationalNumberBy1 [
	| result |

	result := rationalNumbersCalculator divR1: #(1 2 ) r2: #(1 1 ) .
	self assert: result equals: #(1 2 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticDivisionDivideTwoNegativeRationalNumbers [
	| result |

	result := rationalNumbersCalculator divR1: #( -1 2 ) r2: #( -2 3 ) .
	self assert: result equals: #(3 4 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticDivisionDivideTwoPositiveRationalNumbers [
	| result |

	result := rationalNumbersCalculator divR1: #(1 2 ) r2: #(2 3 ) .
	self assert: result equals: #(3 4 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticMultiplicationMultiplyANegativeRationalNumberByAPositiveRationalNumber [
	| result |

	result := rationalNumbersCalculator mulR1: #( -1 2 ) r2: #(2 3 ) .
	self assert: result equals: #( -1 3 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticMultiplicationMultiplyARationalNumberBy0 [
	| result |

	result := rationalNumbersCalculator mulR1: #(1 2 ) r2: #(0 1 ) .
	self assert: result equals: #(0 1 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticMultiplicationMultiplyARationalNumberBy1 [
	| result |

	result := rationalNumbersCalculator mulR1: #(1 2 ) r2: #(1 1 ) .
	self assert: result equals: #(1 2 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticMultiplicationMultiplyARationalNumberByItsReciprocal [
	| result |

	result := rationalNumbersCalculator mulR1: #(1 2 ) r2: #(2 1 ) .
	self assert: result equals: #(1 1 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticMultiplicationMultiplyTwoNegativeRationalNumbers [
	| result |

	result := rationalNumbersCalculator mulR1: #( -1 2 ) r2: #( -2 3 ) .
	self assert: result equals: #(1 3 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticMultiplicationMultiplyTwoPositiveRationalNumbers [
	| result |

	result := rationalNumbersCalculator mulR1: #(1 2 ) r2: #(2 3 ) .
	self assert: result equals: #(1 3 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticSubtractionSubtractAPositiveRationalNumberAndANegativeRationalNumber [
	| result |

	result := rationalNumbersCalculator subR1: #(1 2 ) r2: #( -2 3 ) .
	self assert: result equals: #(7 6 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticSubtractionSubtractARationalNumberFromItself [
	| result |

	result := rationalNumbersCalculator subR1: #(1 2 ) r2: #(1 2 ) .
	self assert: result equals: #(0 1 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticSubtractionSubtractTwoNegativeRationalNumbers [
	| result |

	result := rationalNumbersCalculator subR1: #( -1 2 ) r2: #( -2 3 ) .
	self assert: result equals: #(1 6 )
]

{ #category : #test }
RationalNumbersTest >> testArithmeticSubtractionSubtractTwoPositiveRationalNumbers [
	| result |

	result := rationalNumbersCalculator subR1: #(1 2 ) r2: #(2 3 ) .
	self assert: result equals: #( -1 6 )
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARationalNumberRaiseANegativeRationalNumberToAPositiveIntegerPower [
	| result |

	result := rationalNumbersCalculator exprationalR: #( -1 2 ) n: 3 .
	self assert: result equals: #( -1 8 )
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARationalNumberRaiseANegativeRationalNumberToThePowerOfZero [
	| result |

	result := rationalNumbersCalculator exprationalR: #( -1 2 ) n: 0 .
	self assert: result equals: #(1 1 )
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARationalNumberRaiseAPositiveRationalNumberToAPositiveIntegerPower [
	| result |

	result := rationalNumbersCalculator exprationalR: #(1 2 ) n: 3 .
	self assert: result equals: #(1 8 )
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARationalNumberRaiseAPositiveRationalNumberToThePowerOfZero [
	| result |

	result := rationalNumbersCalculator exprationalR: #(1 2 ) n: 0 .
	self assert: result equals: #(1 1 )
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARationalNumberRaiseOneToAnIntegerPower [
	| result |

	result := rationalNumbersCalculator exprationalR: #(1 1 ) n: 4 .
	self assert: result equals: #(1 1 )
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARationalNumberRaiseZeroToAnIntegerPower [
	| result |

	result := rationalNumbersCalculator exprationalR: #(0 1 ) n: 5 .
	self assert: result equals: #(0 1 )
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARealNumberToARationalNumberRaiseARealNumberToANegativeRationalNumber [
	| result |

	result := rationalNumbersCalculator exprealX: 9 r: #( -1 2 ) .
	self assert: result equals: 0.3333333333333333
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARealNumberToARationalNumberRaiseARealNumberToAPositiveRationalNumber [
	| result |

	result := rationalNumbersCalculator exprealX: 8 r: #(4 3 ) .
	self assert: result equals: 16.0
]

{ #category : #test }
RationalNumbersTest >> testExponentiationOfARealNumberToARationalNumberRaiseARealNumberToAZeroRationalNumber [
	| result |

	result := rationalNumbersCalculator exprealX: 2 r: #(0 1 ) .
	self assert: result equals: 1.0
]

{ #category : #test }
RationalNumbersTest >> testReductionToLowestTermsReduceANegativeRationalNumberToLowestTerms [
	| result |

	result := rationalNumbersCalculator reduceR: #( -4 6 ) .
	self assert: result equals: #( -2 3 )
]

{ #category : #test }
RationalNumbersTest >> testReductionToLowestTermsReduceAPositiveRationalNumberToLowestTerms [
	| result |

	result := rationalNumbersCalculator reduceR: #(2 4 ) .
	self assert: result equals: #(1 2 )
]

{ #category : #test }
RationalNumbersTest >> testReductionToLowestTermsReduceARationalNumberWithANegativeDenominatorToLowestTerms [
	| result |

	result := rationalNumbersCalculator reduceR: #(3  -9 ) .
	self assert: result equals: #( -1 3 )
]

{ #category : #test }
RationalNumbersTest >> testReductionToLowestTermsReduceAnIntegerToLowestTerms [
	| result |

	result := rationalNumbersCalculator reduceR: #( -14 7 ) .
	self assert: result equals: #( -2 1 )
]

{ #category : #test }
RationalNumbersTest >> testReductionToLowestTermsReduceOneToLowestTerms [
	| result |

	result := rationalNumbersCalculator reduceR: #(13 13 ) .
	self assert: result equals: #(1 1 )
]

{ #category : #test }
RationalNumbersTest >> testReductionToLowestTermsReduceZeroToLowestTerms [
	| result |

	result := rationalNumbersCalculator reduceR: #(0 6 ) .
	self assert: result equals: #(0 1 )
]
