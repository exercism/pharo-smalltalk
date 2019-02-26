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
	#name : #WordyTest,
	#superclass : #ExercismTest,
	#instVars : [
		'wordyCalculator'
	],
	#category : #'ExercismWIP-Wordy'
}

{ #category : #config }
WordyTest class >> uuid [
	"Answer a unique id for this exercise"
	^'900c15da-2b3f-0d00-a2ec-d34e09f0590c'
]

{ #category : #config }
WordyTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.5.0'
]

{ #category : #setup }
WordyTest >> setUp [
	wordyCalculator := Wordy new
]

{ #category : #test }
WordyTest >> testAddition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus 1?' .
	self assert: result equals: 2
]

{ #category : #test }
WordyTest >> testAdditionAndMultiplication [
	| result |

	result := wordyCalculator answerQuestion: 'What is -3 plus 7 multiplied by -2?' .
	self assert: result equals:  -8
]

{ #category : #test }
WordyTest >> testAdditionAndSubtraction [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus 5 minus -2?' .
	self assert: result equals: 8
]

{ #category : #test }
WordyTest >> testAdditionWithNegativeNumbers [
	| result |

	result := wordyCalculator answerQuestion: 'What is -1 plus -10?' .
	self assert: result equals:  -11
]

{ #category : #test }
WordyTest >> testDivision [
	| result |

	result := wordyCalculator answerQuestion: 'What is 33 divided by -3?' .
	self assert: result equals:  -11
]

{ #category : #test }
WordyTest >> testJustANumber [
	| result |

	result := wordyCalculator answerQuestion: 'What is 5?' .
	self assert: result equals: 5
]

{ #category : #test }
WordyTest >> testLargeAddition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 123 plus 45678?' .
	self assert: result equals: 45801
]

{ #category : #test }
WordyTest >> testMoreAddition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 53 plus 2?' .
	self assert: result equals: 55
]

{ #category : #test }
WordyTest >> testMultipleAdditions [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus 1 plus 1?' .
	self assert: result equals: 3
]

{ #category : #test }
WordyTest >> testMultipleDivision [
	| result |

	result := wordyCalculator answerQuestion: 'What is -12 divided by 2 divided by -3?' .
	self assert: result equals: 2
]

{ #category : #test }
WordyTest >> testMultipleMultiplication [
	| result |

	result := wordyCalculator answerQuestion: 'What is 2 multiplied by -2 multiplied by 3?' .
	self assert: result equals:  -12
]

{ #category : #test }
WordyTest >> testMultipleSubtraction [
	| result |

	result := wordyCalculator answerQuestion: 'What is 20 minus 4 minus 13?' .
	self assert: result equals: 3
]

{ #category : #test }
WordyTest >> testMultiplication [
	| result |

	result := wordyCalculator answerQuestion: 'What is -3 multiplied by 25?' .
	self assert: result equals:  -75
]

{ #category : #test }
WordyTest >> testNonMathQuestion [
	| result |

	result := wordyCalculator answerQuestion: 'Who is the President of the United States?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'unknown operation'); yourself)
]

{ #category : #test }
WordyTest >> testRejectPostfixNotation [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 2 plus?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'syntax error'); yourself)
]

{ #category : #test }
WordyTest >> testRejectPrefixNotation [
	| result |

	result := wordyCalculator answerQuestion: 'What is plus 1 2?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'syntax error'); yourself)
]

{ #category : #test }
WordyTest >> testRejectProblemMissingAnOperand [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'syntax error'); yourself)
]

{ #category : #test }
WordyTest >> testRejectProblemWithNoOperandsOrOperators [
	| result |

	result := wordyCalculator answerQuestion: 'What is?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'syntax error'); yourself)
]

{ #category : #test }
WordyTest >> testRejectTwoNumbersInARow [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus 2 1?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'syntax error'); yourself)
]

{ #category : #test }
WordyTest >> testRejectTwoOperationsInARow [
	| result |

	result := wordyCalculator answerQuestion: 'What is 1 plus plus 2?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'syntax error'); yourself)
]

{ #category : #test }
WordyTest >> testSubtraction [
	| result |

	result := wordyCalculator answerQuestion: 'What is 4 minus -12?' .
	self assert: result equals: 16
]

{ #category : #test }
WordyTest >> testSubtractionThenAddition [
	| result |

	result := wordyCalculator answerQuestion: 'What is 17 minus 6 plus 3?' .
	self assert: result equals: 14
]

{ #category : #test }
WordyTest >> testUnknownOperation [
	| result |

	result := wordyCalculator answerQuestion: 'What is 52 cubed?' .
	self assert: result equals: ((Dictionary new) add: ('error'->'unknown operation'); yourself)
]
