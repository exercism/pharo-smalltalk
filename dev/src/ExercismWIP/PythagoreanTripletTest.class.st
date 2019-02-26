"
# Pythagorean Triplet

A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for
which,

```text
a**2 + b**2 = c**2
```

and such that,

```text
a < b < c
```

For example,

```text
3**2 + 4**2 = 9 + 16 = 25 = 5**2.
```

Given an input integer N, find all Pythagorean triplets for which `a + b + c = N`.

For example, with N = 1000, there is exactly one Pythagorean triplet for which `a + b + c = 1000`: `{200, 375, 425}`.

## Hint

TBD

"
Class {
	#name : #PythagoreanTripletTest,
	#superclass : #ExercismTest,
	#instVars : [
		'pythagoreanTripletCalculator'
	],
	#category : #'ExercismWIP-PythagoreanTriplet'
}

{ #category : #config }
PythagoreanTripletTest class >> uuid [
	"Answer a unique id for this exercise"
	^'a0b313da-2b3f-0d00-a2eb-5d3b09f0590c'
]

{ #category : #config }
PythagoreanTripletTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
PythagoreanTripletTest >> setUp [
	pythagoreanTripletCalculator := PythagoreanTriplet new
]

{ #category : #test }
PythagoreanTripletTest >> testNoMatchingTripletsFor1001 [
	| result |

	result := pythagoreanTripletCalculator tripletsWithSumN: 1001 .
	self assert: result equals: #()
]

{ #category : #test }
PythagoreanTripletTest >> testReturnsAllMatchingTriplets [
	| result |

	result := pythagoreanTripletCalculator tripletsWithSumN: 90 .
	self assert: result equals: #(#(9 40 41 ) #(15 36 39 ) )
]

{ #category : #test }
PythagoreanTripletTest >> testSeveralMatchingTriplets [
	| result |

	result := pythagoreanTripletCalculator tripletsWithSumN: 840 .
	self assert: result equals: #(#(40 399 401 ) #(56 390 394 ) #(105 360 375 ) #(120 350 370 ) #(140 336 364 ) #(168 315 357 ) #(210 280 350 ) #(240 252 348 ) )
]

{ #category : #test }
PythagoreanTripletTest >> testTripletsForLargeNumber [
	| result |

	result := pythagoreanTripletCalculator tripletsWithSumN: 30000 .
	self assert: result equals: #(#(1200 14375 14425 ) #(1875 14000 14125 ) #(5000 12000 13000 ) #(6000 11250 12750 ) #(7500 10000 12500 ) )
]

{ #category : #test }
PythagoreanTripletTest >> testTripletsWhoseSumIs1000 [
	| result |

	result := pythagoreanTripletCalculator tripletsWithSumN: 1000 .
	self assert: result equals: #(#(200 375 425 ) )
]

{ #category : #test }
PythagoreanTripletTest >> testTripletsWhoseSumIs108 [
	| result |

	result := pythagoreanTripletCalculator tripletsWithSumN: 108 .
	self assert: result equals: #(#(27 36 45 ) )
]

{ #category : #test }
PythagoreanTripletTest >> testTripletsWhoseSumIs12 [
	| result |

	result := pythagoreanTripletCalculator tripletsWithSumN: 12 .
	self assert: result equals: #(#(3 4 5 ) )
]
