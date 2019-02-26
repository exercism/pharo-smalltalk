"
# Roman Numerals

Write a function to convert from normal numbers to Roman Numerals.

The Romans were a clever bunch. They conquered most of Europe and ruled
it for hundreds of years. They invented concrete and straight roads and
even bikinis. One thing they never discovered though was the number
zero. This made writing and dating extensive histories of their exploits
slightly more challenging, but the system of numbers they came up with
is still in use today. For example the BBC uses Roman numerals to date
their programmes.

The Romans wrote numbers using letters - I, V, X, L, C, D, M. (notice
these letters have lots of straight lines and are hence easy to hack
into stone tablets).

```text
 1  => I
10  => X
 7  => VII
```

There is no need to be able to convert numbers larger than about 3000.
(The Romans themselves didn't tend to go any higher)

Wikipedia says: Modern Roman numerals ... are written by expressing each
digit separately starting with the left most digit and skipping any
digit with a value of zero.

To see this in practice, consider the example of 1990.

In Roman numerals 1990 is MCMXC:

1000=M
900=CM
90=XC

2008 is written as MMVIII:

2000=MM
8=VIII

See also: http://www.novaroma.org/via_romana/numbers.html

## Hint

TBD

"
Class {
	#name : #RomanNumeralsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'romanNumeralsCalculator'
	],
	#category : #'ExercismWIP-RomanNumerals'
}

{ #category : #config }
RomanNumeralsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'5e9dd4d9-2b3f-0d00-a2ac-6f6309f0590c'
]

{ #category : #config }
RomanNumeralsTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
RomanNumeralsTest >> setUp [
	romanNumeralsCalculator := RomanNumerals new
]

{ #category : #test }
RomanNumeralsTest >> test1000IsASingleM [
	| result |

	result := romanNumeralsCalculator romanNumber: 1024 .
	self assert: result equals: 'MXXIV'
]

{ #category : #test }
RomanNumeralsTest >> test100IsASingleC [
	| result |

	result := romanNumeralsCalculator romanNumber: 141 .
	self assert: result equals: 'CXLI'
]

{ #category : #test }
RomanNumeralsTest >> test1IsASingleI [
	| result |

	result := romanNumeralsCalculator romanNumber: 1 .
	self assert: result equals: 'I'
]

{ #category : #test }
RomanNumeralsTest >> test20IsTwoXs [
	| result |

	result := romanNumeralsCalculator romanNumber: 27 .
	self assert: result equals: 'XXVII'
]

{ #category : #test }
RomanNumeralsTest >> test2IsTwoIs [
	| result |

	result := romanNumeralsCalculator romanNumber: 2 .
	self assert: result equals: 'II'
]

{ #category : #test }
RomanNumeralsTest >> test3000IsThreeMs [
	| result |

	result := romanNumeralsCalculator romanNumber: 3000 .
	self assert: result equals: 'MMM'
]

{ #category : #test }
RomanNumeralsTest >> test3IsThreeIs [
	| result |

	result := romanNumeralsCalculator romanNumber: 3 .
	self assert: result equals: 'III'
]

{ #category : #test }
RomanNumeralsTest >> test400Being500100IsCD [
	| result |

	result := romanNumeralsCalculator romanNumber: 402 .
	self assert: result equals: 'CDII'
]

{ #category : #test }
RomanNumeralsTest >> test48IsNot502ButRather408 [
	| result |

	result := romanNumeralsCalculator romanNumber: 48 .
	self assert: result equals: 'XLVIII'
]

{ #category : #test }
RomanNumeralsTest >> test49IsNot4054ButRather5010101 [
	| result |

	result := romanNumeralsCalculator romanNumber: 49 .
	self assert: result equals: 'XLIX'
]

{ #category : #test }
RomanNumeralsTest >> test4Being51IsIV [
	| result |

	result := romanNumeralsCalculator romanNumber: 4 .
	self assert: result equals: 'IV'
]

{ #category : #test }
RomanNumeralsTest >> test500IsASingleD [
	| result |

	result := romanNumeralsCalculator romanNumber: 575 .
	self assert: result equals: 'DLXXV'
]

{ #category : #test }
RomanNumeralsTest >> test50IsASingleL [
	| result |

	result := romanNumeralsCalculator romanNumber: 59 .
	self assert: result equals: 'LIX'
]

{ #category : #test }
RomanNumeralsTest >> test5IsASingleV [
	| result |

	result := romanNumeralsCalculator romanNumber: 5 .
	self assert: result equals: 'V'
]

{ #category : #test }
RomanNumeralsTest >> test60Being5010IsLX [
	| result |

	result := romanNumeralsCalculator romanNumber: 163 .
	self assert: result equals: 'CLXIII'
]

{ #category : #test }
RomanNumeralsTest >> test6Being51IsVI [
	| result |

	result := romanNumeralsCalculator romanNumber: 6 .
	self assert: result equals: 'VI'
]

{ #category : #test }
RomanNumeralsTest >> test900Being1000100IsCM [
	| result |

	result := romanNumeralsCalculator romanNumber: 911 .
	self assert: result equals: 'CMXI'
]

{ #category : #test }
RomanNumeralsTest >> test90Being10010IsXC [
	| result |

	result := romanNumeralsCalculator romanNumber: 93 .
	self assert: result equals: 'XCIII'
]

{ #category : #test }
RomanNumeralsTest >> test9Being101IsIX [
	| result |

	result := romanNumeralsCalculator romanNumber: 9 .
	self assert: result equals: 'IX'
]
