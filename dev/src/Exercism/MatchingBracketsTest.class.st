"
# Matching Brackets

Given a string containing brackets `[]`, braces `{}`, parentheses `()`,
or any combination thereof, verify that any and all pairs are matched
and nested correctly.

## Hint

Saving state in a useful data type can help here.


"
Class {
	#name : #MatchingBracketsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'bracketPushCalculator'
	],
	#category : #'Exercism-MatchingBrackets'
}

{ #category : #config }
MatchingBracketsTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(self createExerciseAfter: LeapTest)
		isCore: false;
		difficulty: 4;
		topics: #('strings' 'parsing' 'stacks');
		yourself
	
]

{ #category : #generator }
MatchingBracketsTest class >> generator [
	"Potential generator hints"
	
	^ {('@isPairedValue:' -> #isPaired:)}
]

{ #category : #config }
MatchingBracketsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d126be16-9d41-0d00-8fdc-2ff208866539'
]

{ #category : #config }
MatchingBracketsTest class >> version [
	"Generated from specification: 24 April 2019"
	^'2.0.0'
]

{ #category : #setup }
MatchingBracketsTest >> setUp [
	bracketPushCalculator := MatchingBrackets new
]

{ #category : #tests }
MatchingBracketsTest >> test01_PairedSquareBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[]' .
	self assert: result equals: true
]

{ #category : #tests }
MatchingBracketsTest >> test02_EmptyString [
	| result |

	result := bracketPushCalculator isPaired: '' .
	self assert: result equals: true
]

{ #category : #tests }
MatchingBracketsTest >> test03_UnpairedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[[' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test04_WrongOrderedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '}{' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test05_WrongClosingBracket [
	| result |

	result := bracketPushCalculator isPaired: '{]' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test06_PairedWithWhitespace [
	| result |

	result := bracketPushCalculator isPaired: '{ }' .
	self assert: result equals: true
]

{ #category : #tests }
MatchingBracketsTest >> test07_PartiallyPairedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{[])' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test08_SimpleNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{[]}' .
	self assert: result equals: true
]

{ #category : #tests }
MatchingBracketsTest >> test09_SeveralPairedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{}[]' .
	self assert: result equals: true
]

{ #category : #tests }
MatchingBracketsTest >> test10_PairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '([{}({}[])])' .
	self assert: result equals: true
]

{ #category : #tests }
MatchingBracketsTest >> test11_UnopenedClosingBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{[)][]}' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test12_UnpairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '([{])' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test13_PairedAndWrongNestedBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[({]})' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test14_PairedAndIncompleteBrackets [
	| result |

	result := bracketPushCalculator isPaired: '{}[' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test15_TooManyClosingBrackets [
	| result |

	result := bracketPushCalculator isPaired: '[]]' .
	self assert: result equals: false
]

{ #category : #tests }
MatchingBracketsTest >> test16_MathExpression [
	| result |

	result := bracketPushCalculator isPaired: '(((185 + 223.85) * 15) - 543)/2' .
	self assert: result equals: true
]

{ #category : #tests }
MatchingBracketsTest >> test17_ComplexLatexExpression [
	| result |

	result := bracketPushCalculator isPaired: '\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)' .
	self assert: result equals: true
]
