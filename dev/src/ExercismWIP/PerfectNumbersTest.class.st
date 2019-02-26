"
# Perfect Numbers

Determine if a number is perfect, abundant, or deficient based on
Nicomachus' (60 - 120 CE) classification scheme for natural numbers.

The Greek mathematician [Nicomachus](https://en.wikipedia.org/wiki/Nicomachus) devised a classification scheme for natural numbers, identifying each as belonging uniquely to the categories of **perfect**, **abundant**, or **deficient** based on their [aliquot sum](https://en.wikipedia.org/wiki/Aliquot_sum). The aliquot sum is defined as the sum of the factors of a number not including the number itself. For example, the aliquot sum of 15 is (1 + 3 + 5) = 9

- **Perfect**: aliquot sum = number
  - 6 is a perfect number because (1 + 2 + 3) = 6
  - 28 is a perfect number because (1 + 2 + 4 + 7 + 14) = 28
- **Abundant**: aliquot sum > number
  - 12 is an abundant number because (1 + 2 + 3 + 4 + 6) = 16
  - 24 is an abundant number because (1 + 2 + 3 + 4 + 6 + 8 + 12) = 36
- **Deficient**: aliquot sum < number
  - 8 is a deficient number because (1 + 2 + 4) = 7
  - Prime numbers are deficient

Implement a way to determine whether a given number is **perfect**. Depending on your language track, you may also need to implement a way to determine whether a given number is **abundant** or **deficient**.

## Hint

TBD

"
Class {
	#name : #PerfectNumbersTest,
	#superclass : #ExercismTest,
	#instVars : [
		'perfectNumbersCalculator'
	],
	#category : #'ExercismWIP-PerfectNumbers'
}

{ #category : #config }
PerfectNumbersTest class >> uuid [
	"Answer a unique id for this exercise"
	^'f199e1d9-2b3f-0d00-a2ba-52e209f0590c'
]

{ #category : #config }
PerfectNumbersTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
PerfectNumbersTest >> setUp [
	perfectNumbersCalculator := PerfectNumbers new
]

{ #category : #test }
PerfectNumbersTest >> testAbundantNumbersLargeAbundantNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 33550335 .
	self assert: result equals: 'abundant'
]

{ #category : #test }
PerfectNumbersTest >> testAbundantNumbersMediumAbundantNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 30 .
	self assert: result equals: 'abundant'
]

{ #category : #test }
PerfectNumbersTest >> testAbundantNumbersSmallestAbundantNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 12 .
	self assert: result equals: 'abundant'
]

{ #category : #test }
PerfectNumbersTest >> testDeficientNumbersEdgeCasenoFactorsOtherThanItselfIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 1 .
	self assert: result equals: 'deficient'
]

{ #category : #test }
PerfectNumbersTest >> testDeficientNumbersLargeDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 33550337 .
	self assert: result equals: 'deficient'
]

{ #category : #test }
PerfectNumbersTest >> testDeficientNumbersMediumDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 32 .
	self assert: result equals: 'deficient'
]

{ #category : #test }
PerfectNumbersTest >> testDeficientNumbersSmallestNonprimeDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 4 .
	self assert: result equals: 'deficient'
]

{ #category : #test }
PerfectNumbersTest >> testDeficientNumbersSmallestPrimeDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 2 .
	self assert: result equals: 'deficient'
]

{ #category : #test }
PerfectNumbersTest >> testInvalidInputsNegativeIntegerIsRejectednotANaturalNumber [
	| result |

	result := perfectNumbersCalculator classifyNumber:  -1 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Classification is only possible for natural numbers.'); yourself)
]

{ #category : #test }
PerfectNumbersTest >> testInvalidInputsZeroIsRejectednotANaturalNumber [
	| result |

	result := perfectNumbersCalculator classifyNumber: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Classification is only possible for natural numbers.'); yourself)
]

{ #category : #test }
PerfectNumbersTest >> testPerfectNumbersLargePerfectNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 33550336 .
	self assert: result equals: 'perfect'
]

{ #category : #test }
PerfectNumbersTest >> testPerfectNumbersMediumPerfectNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 28 .
	self assert: result equals: 'perfect'
]

{ #category : #test }
PerfectNumbersTest >> testPerfectNumbersSmallestPerfectNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 6 .
	self assert: result equals: 'perfect'
]
