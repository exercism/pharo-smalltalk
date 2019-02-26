"
# Dominoes

Make a chain of dominoes.

Compute a way to order a given set of dominoes in such a way that they form a
correct domino chain (the dots on one half of a stone match the dots on the
neighbouring half of an adjacent stone) and that dots on the halves of the
stones which don't have a neighbour (the first and last stone) match each other.

For example given the stones `[2|1]`, `[2|3]` and `[1|3]` you should compute something
like `[1|2] [2|3] [3|1]` or `[3|2] [2|1] [1|3]` or `[1|3] [3|2] [2|1]` etc, where the first and last numbers are the same.

For stones `[1|2]`, `[4|1]` and `[2|3]` the resulting chain is not valid: `[4|1] [1|2] [2|3]`'s first and last numbers are not the same. 4 != 3

Some test cases may use duplicate stones in a chain solution, assume that multiple Domino sets are being used.

## Hint

TBD

"
Class {
	#name : #DominoesTest,
	#superclass : #ExercismTest,
	#instVars : [
		'dominoesCalculator'
	],
	#category : #'ExercismWIP-Dominoes'
}

{ #category : #config }
DominoesTest class >> uuid [
	"Answer a unique id for this exercise"
	^'85f405da-2b3f-0d00-a2e0-477a09f0590c'
]

{ #category : #config }
DominoesTest class >> version [
	"Generated from specification: 26 February 2019"
	^'2.1.0'
]

{ #category : #setup }
DominoesTest >> setUp [
	dominoesCalculator := Dominoes new
]

{ #category : #test }
DominoesTest >> testCanReverseDominoes [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(1 3 ) #(2 3 ) ) .
	self assert: result equals: true
]

{ #category : #test }
DominoesTest >> testCantBeChained [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(4 1 ) #(2 3 ) ) .
	self assert: result equals: false
]

{ #category : #test }
DominoesTest >> testDisconnectedDoubleLoop [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 1 ) #(3 4 ) #(4 3 ) ) .
	self assert: result equals: false
]

{ #category : #test }
DominoesTest >> testDisconnectedSimple [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 1 ) #(2 2 ) ) .
	self assert: result equals: false
]

{ #category : #test }
DominoesTest >> testDisconnectedSingleIsolated [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 3 ) #(3 1 ) #(4 4 ) ) .
	self assert: result equals: false
]

{ #category : #test }
DominoesTest >> testEmptyInputEmptyOutput [
	| result |

	result := dominoesCalculator canChainDominoes: #() .
	self assert: result equals: true
]

{ #category : #test }
DominoesTest >> testNeedBacktrack [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 3 ) #(3 1 ) #(2 4 ) #(2 4 ) ) .
	self assert: result equals: true
]

{ #category : #test }
DominoesTest >> testNineElements [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(5 3 ) #(3 1 ) #(1 2 ) #(2 4 ) #(1 6 ) #(2 3 ) #(3 4 ) #(5 6 ) ) .
	self assert: result equals: true
]

{ #category : #test }
DominoesTest >> testSeparateLoops [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 3 ) #(3 1 ) #(1 1 ) #(2 2 ) #(3 3 ) ) .
	self assert: result equals: true
]

{ #category : #test }
DominoesTest >> testSingletonInputSingletonOutput [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 1 ) ) .
	self assert: result equals: true
]

{ #category : #test }
DominoesTest >> testSingletonThatCantBeChained [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) ) .
	self assert: result equals: false
]

{ #category : #test }
DominoesTest >> testThreeElements [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(3 1 ) #(2 3 ) ) .
	self assert: result equals: true
]
