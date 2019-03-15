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
	^'dc15eebb-8040-0d00-8136-7e2301deb008'
]

{ #category : #config }
ForthTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.7.0'
]

{ #category : #setup }
ForthTest >> setUp [
	forthCalculator := Forth new
]

{ #category : #tests }
ForthTest >> test01_AdditionCanAddTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 +' ) .
	self assert: result equals: #(3 )
]

{ #category : #tests }
ForthTest >> test01_CaseinsensitivityDUPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 DUP Dup dup' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #tests }
ForthTest >> test01_CombinedArithmeticAdditionAndSubtraction [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 + 4 -' ) .
	self assert: result equals: #( -1 )
]

{ #category : #tests }
ForthTest >> test01_DivisionCanDivideTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('12 3 /' ) .
	self assert: result equals: #(4 )
]

{ #category : #tests }
ForthTest >> test01_DropRemovesTheTopValueOnTheStackIfItIsTheOnlyOne [
	| result |

	result := forthCalculator evaluateInstructions: #('1 drop' ) .
	self assert: result equals: #()
]

{ #category : #tests }
ForthTest >> test01_DupCopiesAValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 dup' ) .
	self assert: result equals: #(1 1 )
]

{ #category : #tests }
ForthTest >> test01_MultiplicationCanMultiplyTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('2 4 *' ) .
	self assert: result equals: #(8 )
]

{ #category : #tests }
ForthTest >> test01_OverCopiesTheSecondElementIfThereAreOnlyTwo [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 over' ) .
	self assert: result equals: #(1 2 1 )
]

{ #category : #tests }
ForthTest >> test01_ParsingAndNumbersNumbersJustGetPushedOntoTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 4 5' ) .
	self assert: result equals: #(1 2 3 4 5 )
]

{ #category : #tests }
ForthTest >> test01_SubtractionCanSubtractTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('3 4 -' ) .
	self assert: result equals: #( -1 )
]

{ #category : #tests }
ForthTest >> test01_SwapSwapsTheTopTwoValuesOnTheStackIfTheyAreTheOnlyOnes [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 swap' ) .
	self assert: result equals: #(2 1 )
]

{ #category : #tests }
ForthTest >> test01_UserdefinedWordsCanConsistOfBuiltinWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': dup-twice dup dup ;' '1 dup-twice' ) .
	self assert: result equals: #(1 1 1 )
]

{ #category : #tests }
ForthTest >> test02_AdditionErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('+' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test02_CaseinsensitivityDROPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 4 DROP Drop drop' ) .
	self assert: result equals: #(1 )
]

{ #category : #tests }
ForthTest >> test02_CombinedArithmeticMultiplicationAndDivision [
	| result |

	result := forthCalculator evaluateInstructions: #('2 4 * 3 /' ) .
	self assert: result equals: #(2 )
]

{ #category : #tests }
ForthTest >> test02_DivisionPerformsIntegerDivision [
	| result |

	result := forthCalculator evaluateInstructions: #('8 3 /' ) .
	self assert: result equals: #(2 )
]

{ #category : #tests }
ForthTest >> test02_DropRemovesTheTopValueOnTheStackIfItIsNotTheOnlyOne [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 drop' ) .
	self assert: result equals: #(1 )
]

{ #category : #tests }
ForthTest >> test02_DupCopiesTheTopValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 dup' ) .
	self assert: result equals: #(1 2 2 )
]

{ #category : #tests }
ForthTest >> test02_MultiplicationErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('*' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test02_OverCopiesTheSecondElementIfThereAreMoreThanTwo [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 over' ) .
	self assert: result equals: #(1 2 3 2 )
]

{ #category : #tests }
ForthTest >> test02_SubtractionErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('-' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test02_SwapSwapsTheTopTwoValuesOnTheStackIfTheyAreNotTheOnlyOnes [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 swap' ) .
	self assert: result equals: #(1 3 2 )
]

{ #category : #tests }
ForthTest >> test02_UserdefinedWordsExecuteInTheRightOrder [
	| result |

	result := forthCalculator evaluateInstructions: #(': countup 1 2 3 ;' 'countup' ) .
	self assert: result equals: #(1 2 3 )
]

{ #category : #tests }
ForthTest >> test03_AdditionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 +' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on stack'); yourself)
]

{ #category : #tests }
ForthTest >> test03_CaseinsensitivitySWAPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 SWAP 3 Swap 4 swap' ) .
	self assert: result equals: #(2 3 4 1 )
]

{ #category : #tests }
ForthTest >> test03_DivisionErrorsIfDividingByZero [
	| result |

	result := forthCalculator evaluateInstructions: #('4 0 /' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'divide by zero'); yourself)
]

{ #category : #tests }
ForthTest >> test03_DropErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('drop' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test03_DupErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('dup' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test03_MultiplicationErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 *' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #tests }
ForthTest >> test03_OverErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('over' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test03_SubtractionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 -' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #tests }
ForthTest >> test03_SwapErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('swap' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test03_UserdefinedWordsCanOverrideOtherUserdefinedWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo dup ;' ': foo dup dup ;' '1 foo' ) .
	self assert: result equals: #(1 1 1 )
]

{ #category : #tests }
ForthTest >> test04_CaseinsensitivityOVERIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 OVER Over over' ) .
	self assert: result equals: #(1 2 1 2 1 )
]

{ #category : #tests }
ForthTest >> test04_DivisionErrorsIfThereIsNothingOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('/' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'empty stack'); yourself)
]

{ #category : #tests }
ForthTest >> test04_OverErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 over' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack stack'); yourself)
]

{ #category : #tests }
ForthTest >> test04_SwapErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 swap' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #tests }
ForthTest >> test04_UserdefinedWordsCanOverrideBuiltinWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': swap dup ;' '1 swap' ) .
	self assert: result equals: #(1 1 )
]

{ #category : #tests }
ForthTest >> test05_CaseinsensitivityUserdefinedWordsAreCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo dup ;' '1 FOO Foo foo' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #tests }
ForthTest >> test05_DivisionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 /' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'only one value on the stack'); yourself)
]

{ #category : #tests }
ForthTest >> test05_UserdefinedWordsCanOverrideBuiltinOperators [
	| result |

	result := forthCalculator evaluateInstructions: #(': + * ;' '3 4 +' ) .
	self assert: result equals: #(12 )
]

{ #category : #tests }
ForthTest >> test06_CaseinsensitivityDefinitionsAreCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #(': SWAP DUP Dup dup ;' '1 swap' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #tests }
ForthTest >> test06_UserdefinedWordsCanUseDifferentWordsWithTheSameName [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo 5 ;' ': bar foo ;' ': foo 6 ;' 'bar foo' ) .
	self assert: result equals: #(5 6 )
]

{ #category : #tests }
ForthTest >> test07_UserdefinedWordsCanDefineWordThatUsesWordWithTheSameName [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo 10 ;' ': foo foo 1 + ;' 'foo' ) .
	self assert: result equals: #(11 )
]

{ #category : #tests }
ForthTest >> test08_UserdefinedWordsCannotRedefineNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #(': 1 2 ;' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'illegal operation'); yourself)
]

{ #category : #tests }
ForthTest >> test09_UserdefinedWordsErrorsIfExecutingANonexistentWord [
	| result |

	result := forthCalculator evaluateInstructions: #('foo' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'undefined operation'); yourself)
]
