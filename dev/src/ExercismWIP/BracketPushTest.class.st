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

	result := bracketPushCalculator isPairedValue: '[]' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test02_EmptyString [
	| result |

	result := bracketPushCalculator isPairedValue: '' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test03_UnpairedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '[[' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test04_WrongOrderedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '}{' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test05_WrongClosingBracket [
	| result |

	result := bracketPushCalculator isPairedValue: '{]' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test06_PairedWithWhitespace [
	| result |

	result := bracketPushCalculator isPairedValue: '{ }' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test07_PartiallyPairedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{[])' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test08_SimpleNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{[]}' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test09_SeveralPairedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{}[]' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test10_PairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '([{}({}[])])' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test11_UnopenedClosingBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{[)][]}' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test12_UnpairedAndNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '([{])' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test13_PairedAndWrongNestedBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '[({]})' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test14_PairedAndIncompleteBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '{}[' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test15_TooManyClosingBrackets [
	| result |

	result := bracketPushCalculator isPairedValue: '[]]' .
	self assert: result equals: false
]

{ #category : #tests }
BracketPushTest >> test16_MathExpression [
	| result |

	result := bracketPushCalculator isPairedValue: '(((185 + 223.85) * 15) - 543)/2' .
	self assert: result equals: true
]

{ #category : #tests }
BracketPushTest >> test17_ComplexLatexExpression [
	| result |

	result := bracketPushCalculator isPairedValue: '\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)' .
	self assert: result equals: true
]
