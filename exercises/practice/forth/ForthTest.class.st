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

It might take several classes and/or instances to model this

"
Class {
	#name : #ForthTest,
	#superclass : #ExercismTest,
	#instVars : [
		'forthCalculator'
	],
	#category : #'Exercise@Forth'
}

{ #category : #config }
ForthTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"

	^ (self createExerciseAfter: GradeSchoolTest)
		isCore: true;
		difficulty: 6;
		topics: #('parsing' 'stacks');
		yourself
]

{ #category : #config }
ForthTest class >> uuid [
	"Answer a unique id for this exercise"
	^'98e35398-a743-0d00-aeac-1c4207045670'
]

{ #category : #config }
ForthTest class >> version [
	"Generated from specification: 24 April 2019"
	^'1.7.0'
]

{ #category : #running }
ForthTest >> setUp [
	super setUp.
	forthCalculator := Forth new
]

{ #category : #tests }
ForthTest >> test01_ParsingAndNumbersNumbersJustGetPushedOntoTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 4 5' ) .
	self assert: result equals: #(1 2 3 4 5 )
]

{ #category : #tests }
ForthTest >> test02_AdditionCanAddTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 +' ) .
	self assert: result equals: #(3 )
]

{ #category : #tests }
ForthTest >> test03_AdditionErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('+' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test04_AdditionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('1 +' ) ]
		raise: Error
		whoseDescriptionIncludes: 'only one value on the stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test05_SubtractionCanSubtractTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('3 4 -' ) .
	self assert: result equals: #( -1 )
]

{ #category : #tests }
ForthTest >> test06_SubtractionErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('-' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test07_SubtractionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('1 -' ) ]
		raise: Error
		whoseDescriptionIncludes: 'only one value on the stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test08_MultiplicationCanMultiplyTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('2 4 *' ) .
	self assert: result equals: #(8 )
]

{ #category : #tests }
ForthTest >> test09_MultiplicationErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('*' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test10_MultiplicationErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('1 *' ) ]
		raise: Error
		whoseDescriptionIncludes: 'only one value on the stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test11_DivisionCanDivideTwoNumbers [
	| result |

	result := forthCalculator evaluateInstructions: #('12 3 /' ) .
	self assert: result equals: #(4 )
]

{ #category : #tests }
ForthTest >> test12_DivisionPerformsIntegerDivision [
	| result |

	result := forthCalculator evaluateInstructions: #('8 3 /' ) .
	self assert: result equals: #(2 )
]

{ #category : #tests }
ForthTest >> test13_DivisionErrorsIfDividingByZero [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('4 0 /' ) ]
		raise: Error
		whoseDescriptionIncludes: 'divide by zero'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test14_DivisionErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('/' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test15_DivisionErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('1 /' ) ]
		raise: Error
		whoseDescriptionIncludes: 'only one value on the stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test16_CombinedArithmeticAdditionAndSubtraction [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 + 4 -' ) .
	self assert: result equals: #( -1 )
]

{ #category : #tests }
ForthTest >> test17_CombinedArithmeticMultiplicationAndDivision [
	| result |

	result := forthCalculator evaluateInstructions: #('2 4 * 3 /' ) .
	self assert: result equals: #(2 )
]

{ #category : #tests }
ForthTest >> test18_DupCopiesAValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 dup' ) .
	self assert: result equals: #(1 1 )
]

{ #category : #tests }
ForthTest >> test19_DupCopiesTheTopValueOnTheStack [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 dup' ) .
	self assert: result equals: #(1 2 2 )
]

{ #category : #tests }
ForthTest >> test20_DupErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('dup' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test21_DropRemovesTheTopValueOnTheStackIfItIsTheOnlyOne [
	| result |

	result := forthCalculator evaluateInstructions: #('1 drop' ) .
	self assert: result equals: #()
]

{ #category : #tests }
ForthTest >> test22_DropRemovesTheTopValueOnTheStackIfItIsNotTheOnlyOne [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 drop' ) .
	self assert: result equals: #(1 )
]

{ #category : #tests }
ForthTest >> test23_DropErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('drop' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test24_SwapSwapsTheTopTwoValuesOnTheStackIfTheyAreTheOnlyOnes [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 swap' ) .
	self assert: result equals: #(2 1 )
]

{ #category : #tests }
ForthTest >> test25_SwapSwapsTheTopTwoValuesOnTheStackIfTheyAreNotTheOnlyOnes [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 swap' ) .
	self assert: result equals: #(1 3 2 )
]

{ #category : #tests }
ForthTest >> test26_SwapErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('swap' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test27_SwapErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('1 swap' ) ]
		raise: Error
		whoseDescriptionIncludes: 'only one value on the stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test28_OverCopiesTheSecondElementIfThereAreOnlyTwo [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 over' ) .
	self assert: result equals: #(1 2 1 )
]

{ #category : #tests }
ForthTest >> test29_OverCopiesTheSecondElementIfThereAreMoreThanTwo [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 over' ) .
	self assert: result equals: #(1 2 3 2 )
]

{ #category : #tests }
ForthTest >> test30_OverErrorsIfThereIsNothingOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('over' ) ]
		raise: Error
		whoseDescriptionIncludes: 'empty stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test31_OverErrorsIfThereIsOnlyOneValueOnTheStack [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('1 over' ) ]
		raise: Error
		whoseDescriptionIncludes: 'only one value on the stack'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test32_UserdefinedWordsCanConsistOfBuiltinWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': dup-twice dup dup ;' '1 dup-twice' ) .
	self assert: result equals: #(1 1 1 )
]

{ #category : #tests }
ForthTest >> test33_UserdefinedWordsExecuteInTheRightOrder [
	| result |

	result := forthCalculator evaluateInstructions: #(': countup 1 2 3 ;' 'countup' ) .
	self assert: result equals: #(1 2 3 )
]

{ #category : #tests }
ForthTest >> test34_UserdefinedWordsCanOverrideOtherUserdefinedWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo dup ;' ': foo dup dup ;' '1 foo' ) .
	self assert: result equals: #(1 1 1 )
]

{ #category : #tests }
ForthTest >> test35_UserdefinedWordsCanOverrideBuiltinWords [
	| result |

	result := forthCalculator evaluateInstructions: #(': swap dup ;' '1 swap' ) .
	self assert: result equals: #(1 1 )
]

{ #category : #tests }
ForthTest >> test36_UserdefinedWordsCanOverrideBuiltinOperators [
	| result |

	result := forthCalculator evaluateInstructions: #(': + * ;' '3 4 +' ) .
	self assert: result equals: #(12 )
]

{ #category : #tests }
ForthTest >> test37_UserdefinedWordsCanUseDifferentWordsWithTheSameName [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo 5 ;' ': bar foo ;' ': foo 6 ;' 'bar foo' ) .
	self assert: result equals: #(5 6 )
]

{ #category : #tests }
ForthTest >> test38_UserdefinedWordsCanDefineWordThatUsesWordWithTheSameName [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo 10 ;' ': foo foo 1 + ;' 'foo' ) .
	self assert: result equals: #(11 )
]

{ #category : #tests }
ForthTest >> test39_UserdefinedWordsCannotRedefineNumbers [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #(': 1 2 ;' ) ]
		raise: Error
		whoseDescriptionIncludes: 'illegal operation'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test40_UserdefinedWordsErrorsIfExecutingANonexistentWord [
	| result |

	self
		should: [ result := forthCalculator evaluateInstructions: #('foo' ) ]
		raise: Error
		whoseDescriptionIncludes: 'undefined operation'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
ForthTest >> test41_CaseinsensitivityDUPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 DUP Dup dup' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #tests }
ForthTest >> test42_CaseinsensitivityDROPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 3 4 DROP Drop drop' ) .
	self assert: result equals: #(1 )
]

{ #category : #tests }
ForthTest >> test43_CaseinsensitivitySWAPIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 SWAP 3 Swap 4 swap' ) .
	self assert: result equals: #(2 3 4 1 )
]

{ #category : #tests }
ForthTest >> test44_CaseinsensitivityOVERIsCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #('1 2 OVER Over over' ) .
	self assert: result equals: #(1 2 1 2 1 )
]

{ #category : #tests }
ForthTest >> test45_CaseinsensitivityUserdefinedWordsAreCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #(': foo dup ;' '1 FOO Foo foo' ) .
	self assert: result equals: #(1 1 1 1 )
]

{ #category : #tests }
ForthTest >> test46_CaseinsensitivityDefinitionsAreCaseinsensitive [
	| result |

	result := forthCalculator evaluateInstructions: #(': SWAP DUP Dup dup ;' '1 swap' ) .
	self assert: result equals: #(1 1 1 1 )
]
