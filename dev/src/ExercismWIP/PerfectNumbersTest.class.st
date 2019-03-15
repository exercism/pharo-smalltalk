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
	^'17ceb5bb-8040-0d00-80f2-2dce01deb008'
]

{ #category : #config }
PerfectNumbersTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.1.0'
]

{ #category : #setup }
PerfectNumbersTest >> setUp [
	perfectNumbersCalculator := PerfectNumbers new
]

{ #category : #tests }
PerfectNumbersTest >> test01_AbundantNumbersSmallestAbundantNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 12 .
	self assert: result equals: 'abundant'
]

{ #category : #tests }
PerfectNumbersTest >> test01_DeficientNumbersSmallestPrimeDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 2 .
	self assert: result equals: 'deficient'
]

{ #category : #tests }
PerfectNumbersTest >> test01_InvalidInputsZeroIsRejectednotANaturalNumber [
	| result |

	result := perfectNumbersCalculator classifyNumber: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Classification is only possible for natural numbers.'); yourself)
]

{ #category : #tests }
PerfectNumbersTest >> test01_PerfectNumbersSmallestPerfectNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 6 .
	self assert: result equals: 'perfect'
]

{ #category : #tests }
PerfectNumbersTest >> test02_AbundantNumbersMediumAbundantNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 30 .
	self assert: result equals: 'abundant'
]

{ #category : #tests }
PerfectNumbersTest >> test02_DeficientNumbersSmallestNonprimeDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 4 .
	self assert: result equals: 'deficient'
]

{ #category : #tests }
PerfectNumbersTest >> test02_InvalidInputsNegativeIntegerIsRejectednotANaturalNumber [
	| result |

	result := perfectNumbersCalculator classifyNumber:  -1 .
	self assert: result equals: ((Dictionary new) add: ('error'->'Classification is only possible for natural numbers.'); yourself)
]

{ #category : #tests }
PerfectNumbersTest >> test02_PerfectNumbersMediumPerfectNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 28 .
	self assert: result equals: 'perfect'
]

{ #category : #tests }
PerfectNumbersTest >> test03_AbundantNumbersLargeAbundantNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 33550335 .
	self assert: result equals: 'abundant'
]

{ #category : #tests }
PerfectNumbersTest >> test03_DeficientNumbersMediumDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 32 .
	self assert: result equals: 'deficient'
]

{ #category : #tests }
PerfectNumbersTest >> test03_PerfectNumbersLargePerfectNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 33550336 .
	self assert: result equals: 'perfect'
]

{ #category : #tests }
PerfectNumbersTest >> test04_DeficientNumbersLargeDeficientNumberIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 33550337 .
	self assert: result equals: 'deficient'
]

{ #category : #tests }
PerfectNumbersTest >> test05_DeficientNumbersEdgeCasenoFactorsOtherThanItselfIsClassifiedCorrectly [
	| result |

	result := perfectNumbersCalculator classifyNumber: 1 .
	self assert: result equals: 'deficient'
]
