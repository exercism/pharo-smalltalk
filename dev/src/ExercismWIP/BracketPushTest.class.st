"
# Bracket Push

Given a string containing brackets `[]`, braces `{}`, parentheses `()`,
or any combination thereof, verify that any and all pairs are matched
and nested correctly.

## Hint

TBD

"
Class {
	#name : #BracketPushTest,
	#superclass : #ExercismTest,
	#instVars : [
		'bracketPushCalculator'
	],
	#category : #'ExercismWIP-BracketPush'
}

{ #category : #config }
BracketPushTest class >> uuid [
	"Answer a unique id for this exercise"
	^'1ce5f3d9-2b3f-0d00-a2cd-193a09f0590c'
]

{ #category : #config }
BracketPushTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.5.0'
]

{ #category : #setup }
BracketPushTest >> setUp [
	bracketPushCalculator := BracketPush new
]

{ #category : #test }
BracketPushTest >> testComplexLatexExpression [
	| result |

	result := bracketPushCalculator isPairedValue: '\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testEmptyString [
	| result |

	result := bracketPushCalculator isPairedValue: '' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testMathExpression [
	| result |

	result := bracketPushCalculator isPairedValue: '(((185 + 223.85) * 15) - 543)/2' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testPairedAndIncompleteBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{}[' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testPairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '([{}({}[])])' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testPairedAndWrongNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '[({]})' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testPairedSquareBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '[]' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testPairedWithWhitespace [
	| result |

	result := bracketPushCalculator isPairedValue: '{ }' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testPartiallyPairedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{[])' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testSeveralPairedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{}[]' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testSimpleNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{[]}' .
	self assert: result equals: true
]

{ #category : #test }
BracketPushTest >> testTooManyClosingBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '[]]' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testUnopenedClosingBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{[)][]}' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testUnpairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '([{])' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testUnpairedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '[[' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testWrongClosingBracket [
	| result |

	result := bracketPushCalculator isPairedValue: '{]' .
	self assert: result equals: false
]

{ #category : #test }
BracketPushTest >> testWrongOrderedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '}{' .
	self assert: result equals: false
]
