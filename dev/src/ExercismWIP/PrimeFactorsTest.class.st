"
# Prime Factors

Compute the prime factors of a given natural number.

A prime number is only evenly divisible by itself and 1.

Note that 1 is not a prime number.

## Example

What are the prime factors of 60?

- Our first divisor is 2. 2 goes into 60, leaving 30.
- 2 goes into 30, leaving 15.
  - 2 doesn't go cleanly into 15. So let's move on to our next divisor, 3.
- 3 goes cleanly into 15, leaving 5.
  - 3 does not go cleanly into 5. The next possible factor is 4.
  - 4 does not go cleanly into 5. The next possible factor is 5.
- 5 does go cleanly into 5.
- We're left only with 1, so now, we're done.

Our successful divisors in that computation represent the list of prime
factors of 60: 2, 2, 3, and 5.

You can check this yourself:

- 2 * 2 * 3 * 5
- = 4 * 15
- = 60
- Success!

## Hint

TBD

"
Class {
	#name : #PrimeFactorsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'primeFactorsCalculator'
	],
	#category : #'ExercismWIP-PrimeFactors'
}

{ #category : #config }
PrimeFactorsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'b009ecbb-8040-0d00-8134-796301deb008'
]

{ #category : #config }
PrimeFactorsTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.1.0'
]

{ #category : #setup }
PrimeFactorsTest >> setUp [
	primeFactorsCalculator := PrimeFactors new
]

{ #category : #tests }
PrimeFactorsTest >> test01_ReturnsPrimeFactorsForTheGivenInputNumberNoFactors [
	| result |

	result := primeFactorsCalculator factorsValue: 1 .
	self assert: result equals: #()
]

{ #category : #tests }
PrimeFactorsTest >> test02_ReturnsPrimeFactorsForTheGivenInputNumberPrimeNumber [
	| result |

	result := primeFactorsCalculator factorsValue: 2 .
	self assert: result equals: #(2 )
]

{ #category : #tests }
PrimeFactorsTest >> test03_ReturnsPrimeFactorsForTheGivenInputNumberSquareOfAPrime [
	| result |

	result := primeFactorsCalculator factorsValue: 9 .
	self assert: result equals: #(3 3 )
]

{ #category : #tests }
PrimeFactorsTest >> test04_ReturnsPrimeFactorsForTheGivenInputNumberCubeOfAPrime [
	| result |

	result := primeFactorsCalculator factorsValue: 8 .
	self assert: result equals: #(2 2 2 )
]

{ #category : #tests }
PrimeFactorsTest >> test05_ReturnsPrimeFactorsForTheGivenInputNumberProductOfPrimesAndNonprimes [
	| result |

	result := primeFactorsCalculator factorsValue: 12 .
	self assert: result equals: #(2 2 3 )
]

{ #category : #tests }
PrimeFactorsTest >> test06_ReturnsPrimeFactorsForTheGivenInputNumberProductOfPrimes [
	| result |

	result := primeFactorsCalculator factorsValue: 901255 .
	self assert: result equals: #(5 17 23 461 )
]

{ #category : #tests }
PrimeFactorsTest >> test07_ReturnsPrimeFactorsForTheGivenInputNumberFactorsIncludeALargePrime [
	| result |

	result := primeFactorsCalculator factorsValue: 93819012551 .
	self assert: result equals: #(11 9539 894119 )
]
