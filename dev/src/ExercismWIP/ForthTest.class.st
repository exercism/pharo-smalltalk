"
# Forth

Implement an evaluator for a very simple subset of Forth.

[Forth](https://en.wikipedia.org/wiki/Forth_%28programming_language%29)
is a stack-based programming language. Implement a very basic evaluator
for a small subset of Forth.

Your evaluator has to support the following words:

- `+`, `-`, `*`, `/` (integer arithmetic)
- `DUP`, `DROP`, `SWAP`, `OVER` (stack manipulation)

Your evaluator also has to support defining new words using the
customary syntax: `: word-name definition ;`.

To keep things simple the only data type you need to support is signed
integers of at least 16 bits size.

You should use the following rules for the syntax: a number is a
sequence of one or more (ASCII) digits, a word is a sequence of one or
more letters, digits, symbols or punctuation that is not a number.
(Forth probably uses slightly different rules, but this is close
enough.)

Words are case-insensitive.

## Hint

TBD

"
Class {
	#name : #ForthTest,
	#superclass : #ExercismTest,
	#instVars : [
		'forthCalculator'
	],
	#category : #'ExercismWIP-Forth'
}

{ #category : #config }
ForthTest class >> uuid [
	"Answer a unique id for this exercise"
	^'df062dda-2b3f-0d00-a302-df1b09f0590c'
]

{ #category : #config }
ForthTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.7.0'
]

{ #category : #setup }
ForthTest >> setUp [
	forthCalculator := Forth new
]

{ #category : #test }
ForthTest >> testAdditionCanAddTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 +' ) .
	self assert: result equals: #(3 )
]

{ #category : #test }
ForthTest >> testAdditionErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('+' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testAdditionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 +' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on stack'); yourself)
]

{ #category : #test }
ForthTest >> testCaseinsensitivityDROPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 4 DROP Drop drop' ) .
	self assert: result equals: #(1 )
]

{ #category : #test }
ForthTest >> testCaseinsensitivityDUPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 DUP Dup dup' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #test }
ForthTest >> testCaseinsensitivityDefinitionsAreCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #(': SWAP DUP Dup dup ;' '1 swap' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #test }
ForthTest >> testCaseinsensitivityOVERIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 OVER Over over' ) .
	self assert: result equals: #(1 2 1 2 1 )
]

{ #category : #test }
ForthTest >> testCaseinsensitivitySWAPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 SWAP 3 Swap 4 swap' ) .
	self assert: result equals: #(2 3 4 1 )
]

{ #category : #test }
ForthTest >> testCaseinsensitivityUserdefinedWordsAreCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo dup ;' '1 FOO Foo foo' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #test }
ForthTest >> testCombinedArithmeticAdditionAndSubtraction [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 + 4 -' ) .
	self assert: result equals: #( -1 )
]

{ #category : #test }
ForthTest >> testCombinedArithmeticMultiplicationAndDivision [
	| result |

	result := forthCalculator evaluateInstructions: #('2 4 * 3 /' ) .
	self assert: result equals: #(2 )
]

{ #category : #test }
ForthTest >> testDivisionCanDivideTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('12 3 /' ) .
	self assert: result equals: #(4 )
]

{ #category : #test }
ForthTest >> testDivisionErrorsIfDividingByZero [
	| result |

	result := forthCalculator evaluateInstructions: #('4 0 /' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'divide by zero'); yourself)
]

{ #category : #test }
ForthTest >> testDivisionErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('/' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testDivisionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 /' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #test }
ForthTest >> testDivisionPerformsIntegerDivision [
	| result |

	result := forthCalculator evaluateInstructions: #('8 3 /' ) .
	self assert: result equals: #(2 )
]

{ #category : #test }
ForthTest >> testDropErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('drop' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testDropRemovesTheTopValueOnTheStackIfItIsNotTheOnlyOne [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 drop' ) .
	self assert: result equals: #(1 )
]

{ #category : #test }
ForthTest >> testDropRemovesTheTopValueOnTheStackIfItIsTheOnlyOne [
	| result |

	result := forthCalculator evaluateInstructions: #('1 drop' ) .
	self assert: result equals: #()
]

{ #category : #test }
ForthTest >> testDupCopiesAValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 dup' ) .
	self assert: result equals: #(1 1 )
]

{ #category : #test }
ForthTest >> testDupCopiesTheTopValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 dup' ) .
	self assert: result equals: #(1 2 2 )
]

{ #category : #test }
ForthTest >> testDupErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('dup' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testMultiplicationCanMultiplyTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('2 4 *' ) .
	self assert: result equals: #(8 )
]

{ #category : #test }
ForthTest >> testMultiplicationErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('*' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testMultiplicationErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 *' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #test }
ForthTest >> testOverCopiesTheSecondElementIfThereAreMoreThanTwo [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 over' ) .
	self assert: result equals: #(1 2 3 2 )
]

{ #category : #test }
ForthTest >> testOverCopiesTheSecondElementIfThereAreOnlyTwo [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 over' ) .
	self assert: result equals: #(1 2 1 )
]

{ #category : #test }
ForthTest >> testOverErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('over' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testOverErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 over' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack stack'); yourself)
]

{ #category : #test }
ForthTest >> testParsingAndNumbersNumbersJustGetPushedOntoTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 4 5' ) .
	self assert: result equals: #(1 2 3 4 5 )
]

{ #category : #test }
ForthTest >> testSubtractionCanSubtractTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('3 4 -' ) .
	self assert: result equals: #( -1 )
]

{ #category : #test }
ForthTest >> testSubtractionErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('-' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testSubtractionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 -' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #test }
ForthTest >> testSwapErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('swap' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #test }
ForthTest >> testSwapErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 swap' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #test }
ForthTest >> testSwapSwapsTheTopTwoValuesOnTheStackIfTheyAreNotTheOnlyOnes [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 swap' ) .
	self assert: result equals: #(1 3 2 )
]

{ #category : #test }
ForthTest >> testSwapSwapsTheTopTwoValuesOnTheStackIfTheyAreTheOnlyOnes [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 swap' ) .
	self assert: result equals: #(2 1 )
]

{ #category : #test }
ForthTest >> testUserdefinedWordsCanConsistOfBuiltinWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': dup-twice dup dup ;' '1 dup-twice' ) .
	self assert: result equals: #(1 1 1 )
]

{ #category : #test }
ForthTest >> testUserdefinedWordsCanDefineWordThatUsesWordWithTheSameName [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo 10 ;' ': foo foo 1 + ;' 'foo' ) .
	self assert: result equals: #(11 )
]

{ #category : #test }
ForthTest >> testUserdefinedWordsCanOverrideBuiltinOperators [
	| result |

	result := forthCalculator evaluateInstructions: #(': + * ;' '3 4 +' ) .
	self assert: result equals: #(12 )
]

{ #category : #test }
ForthTest >> testUserdefinedWordsCanOverrideBuiltinWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': swap dup ;' '1 swap' ) .
	self assert: result equals: #(1 1 )
]

{ #category : #test }
ForthTest >> testUserdefinedWordsCanOverrideOtherUserdefinedWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo dup ;' ': foo dup dup ;' '1 foo' ) .
	self assert: result equals: #(1 1 1 )
]

{ #category : #test }
ForthTest >> testUserdefinedWordsCanUseDifferentWordsWithTheSameName [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo 5 ;' ': bar foo ;' ': foo 6 ;' 'bar foo' ) .
	self assert: result equals: #(5 6 )
]

{ #category : #test }
ForthTest >> testUserdefinedWordsCannotRedefineNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #(': 1 2 ;' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'illegal operation'); yourself)
]

{ #category : #test }
ForthTest >> testUserdefinedWordsErrorsIfExecutingANonexistentWord [
	| result |

	result := forthCalculator evaluateInstructions: #('foo' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'undefined operation'); yourself)
]

{ #category : #test }
ForthTest >> testUserdefinedWordsExecuteInTheRightOrder [
	| result |

	result := forthCalculator evaluateInstructions: #(': countup 1 2 3 ;' 'countup' ) .
	self assert: result equals: #(1 2 3 )
]
