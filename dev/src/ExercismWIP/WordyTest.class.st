"
# Wordy

Parse and evaluate simple math word problems returning the answer as an integer.

## Iteration 0 — Numbers

Problems with no operations simply evaluate to the number given.

> What is 5?

Evaluates to 5.

## Iteration 1 — Addition

Add two numbers together.

> What is 5 plus 13?

Evaluates to 18.

Handle large numbers and negative numbers.

## Iteration 2 — Subtraction, Multiplication and Division

Now, perform the other three operations.

> What is 7 minus 5?

2

> What is 6 multiplied by 4?

24

> What is 25 divided by 5?

5

## Iteration 3 — Multiple Operations

Handle a set of operations, in sequence.

Since these are verbal word problems, evaluate the expression from
left-to-right, _ignoring the typical order of operations._

> What is 5 plus 13 plus 6?

24

> What is 3 plus 2 multiplied by 3?

15  (i.e. not 9)

## Iteration 4 — Errors

The parser should reject:

* Unsupported operations (""What is 52 cubed?"")
* Non-math questions (""Who is the President of the United States"")
* Word problems with invalid syntax (""What is 1 plus plus 2?"")

## Bonus — Exponentials

If you'd like, handle exponentials.

> What is 2 raised to the 5th power?

32

## Hint

TBD

"
Class {
	#name : 'WordyTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'wordyCalculator'
	],
	#category : 'ExercismWIP-Wordy',
	#package : 'ExercismWIP',
	#tag : 'Wordy'
}

{ #category : 'config' }
WordyTest class >> uuid [
	"Answer a unique id for this exercise"
	^'717ac12e-b043-0d00-9272-9da202a76407'
]

{ #category : 'config' }
WordyTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.5.0'
]

{ #category : 'running' }
WordyTest >> setUp [
	super setUp.
	wordyCalculator := Wordy new
]

{ #category : 'tests' }
WordyTest >> test01_JustANumber [
	| result |

	result := wordyCalculator answerQuestion: 'What is 5?' .
	self assert: result equals: 5
]

{ #category : 'tests' }
WordyTest >> test02_Addition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus 1?' .
	self assert: result equals: 2
]

{ #category : 'tests' }
WordyTest >> test03_MoreAddition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 53 plus 2?' .
	self assert: result equals: 55
]

{ #category : 'tests' }
WordyTest >> test04_AdditionWithNegativeNumbers [
	| result |

	result := wordyCalculator answerQuestion: 'What is -1 plus -10?' .
	self assert: result equals:  -11
]

{ #category : 'tests' }
WordyTest >> test05_LargeAddition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 123 plus 45678?' .
	self assert: result equals: 45801
]

{ #category : 'tests' }
WordyTest >> test06_Subtraction [
	| result |

	result := wordyCalculator answerQuestion: 'What is 4 minus -12?' .
	self assert: result equals: 16
]

{ #category : 'tests' }
WordyTest >> test07_Multiplication [
	| result |

	result := wordyCalculator answerQuestion: 'What is -3 multiplied by 25?' .
	self assert: result equals:  -75
]

{ #category : 'tests' }
WordyTest >> test08_Division [
	| result |

	result := wordyCalculator answerQuestion: 'What is 33 divided by -3?' .
	self assert: result equals:  -11
]

{ #category : 'tests' }
WordyTest >> test09_MultipleAdditions [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus 1 plus 1?' .
	self assert: result equals: 3
]

{ #category : 'tests' }
WordyTest >> test10_AdditionAndSubtraction [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus 5 minus -2?' .
	self assert: result equals: 8
]

{ #category : 'tests' }
WordyTest >> test11_MultipleSubtraction [
	| result |

	result := wordyCalculator answerQuestion: 'What is 20 minus 4 minus 13?' .
	self assert: result equals: 3
]

{ #category : 'tests' }
WordyTest >> test12_SubtractionThenAddition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 17 minus 6 plus 3?' .
	self assert: result equals: 14
]

{ #category : 'tests' }
WordyTest >> test13_MultipleMultiplication [
	| result |

	result := wordyCalculator answerQuestion: 'What is 2 multiplied by -2 multiplied by 3?' .
	self assert: result equals:  -12
]

{ #category : 'tests' }
WordyTest >> test14_AdditionAndMultiplication [
	| result |

	result := wordyCalculator answerQuestion: 'What is -3 plus 7 multiplied by -2?' .
	self assert: result equals:  -8
]

{ #category : 'tests' }
WordyTest >> test15_MultipleDivision [
	| result |

	result := wordyCalculator answerQuestion: 'What is -12 divided by 2 divided by -3?' .
	self assert: result equals: 2
]

{ #category : 'tests' }
WordyTest >> test16_UnknownOperation [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'What is 52 cubed?' ]
		raise: Error
		whoseDescriptionIncludes: 'unknown operation'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
WordyTest >> test17_NonMathQuestion [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'Who is the President of the United States?' ]
		raise: Error
		whoseDescriptionIncludes: 'unknown operation'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
WordyTest >> test18_RejectProblemMissingAnOperand [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'What is 1 plus?' ]
		raise: Error
		whoseDescriptionIncludes: 'syntax error'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
WordyTest >> test19_RejectProblemWithNoOperandsOrOperators [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'What is?' ]
		raise: Error
		whoseDescriptionIncludes: 'syntax error'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
WordyTest >> test20_RejectTwoOperationsInARow [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'What is 1 plus plus 2?' ]
		raise: Error
		whoseDescriptionIncludes: 'syntax error'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
WordyTest >> test21_RejectTwoNumbersInARow [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'What is 1 plus 2 1?' ]
		raise: Error
		whoseDescriptionIncludes: 'syntax error'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
WordyTest >> test22_RejectPostfixNotation [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'What is 1 2 plus?' ]
		raise: Error
		whoseDescriptionIncludes: 'syntax error'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
WordyTest >> test23_RejectPrefixNotation [
	| result |

	self
		should: [ result := wordyCalculator answerQuestion: 'What is plus 1 2?' ]
		raise: Error
		whoseDescriptionIncludes: 'syntax error'
		description: 'Should get an error with the correct description'
]
