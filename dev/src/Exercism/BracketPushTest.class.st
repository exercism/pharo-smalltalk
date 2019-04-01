"
# Bracket Push

Given a string containing brackets `[]`, braces `{}`, parentheses `()`,
or any combination thereof, verify that any and all pairs are matched
and nested correctly.

## Hint

Saving state in a useful data type can help here.


"
Class {
	#name : #BracketPushTest,
	#superclass : #ExercismTest,
	#instVars : [
		'bracketPushCalculator'
	],
	#category : #'Exercism-BracketPush'
}

{ #category : #config }
BracketPushTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(self createExerciseAfter: LeapTest)
		isCore: false;
		difficulty: 4;
		topics: #('strings' 'parsing' 'stacks');
		yourself
	
]

{ #category : #generator }
BracketPushTest class >> generator [
	"Potential generator hints"
	
	^ {('@isPairedValue:' -> #isPaired:)}
]

{ #category : #config }
BracketPushTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d126be16-9d41-0d00-8fdc-2ff208866539'
]

{ #category : #config }
BracketPushTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.5.0'
]

{ #category : #setup }
BracketPushTest >> setUp [
	bracketPushCalculator := BracketPush new
]

{ #category : #tests }
BracketPushTest >> test01_PairedSquareBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[]' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test02_EmptyString [
	| result |

	result := bracketPushCalculator isPaired: '' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test03_UnpairedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[[' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test04_WrongOrderedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '}{' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test05_WrongClosingBracket [
	| result |

	result := bracketPushCalculator isPaired: '{]' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test06_PairedWithWhitespace [
	| result |

	result := bracketPushCalculator isPaired: '{ }' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test07_PartiallyPairedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{[])' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test08_SimpleNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{[]}' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test09_SeveralPairedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{}[]' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test10_PairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '([{}({}[])])' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test11_UnopenedClosingBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{[)][]}' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test12_UnpairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '([{])' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test13_PairedAndWrongNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[({]})' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test14_PairedAndIncompleteBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{}[' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test15_TooManyClosingBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[]]' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test16_MathExpression [
	| result |

	result := bracketPushCalculator isPaired: '(((185 + 223.85) * 15) - 543)/2' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test17_ComplexLatexExpression [
	| result |

	result := bracketPushCalculator isPaired: '\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)' .
	self assert: result equals: true
]
