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
	^'30abb92e-b043-0d00-9268-8a4902a76407'
]

{ #category : #config }
DominoesTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.1.0'
]

{ #category : #setup }
DominoesTest >> setUp [
	dominoesCalculator := Dominoes new
]

{ #category : #tests }
DominoesTest >> test01_EmptyInputEqualsEmptyOutput [
	| result |

	result := dominoesCalculator canChainDominoes: #() .
	self assert: result equals: true
]

{ #category : #tests }
DominoesTest >> test02_SingletonInputEqualsSingletonOutput [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 1 ) ) .
	self assert: result equals: true
]

{ #category : #tests }
DominoesTest >> test03_SingletonThatCantBeChained [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) ) .
	self assert: result equals: false
]

{ #category : #tests }
DominoesTest >> test04_ThreeElements [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(3 1 ) #(2 3 ) ) .
	self assert: result equals: true
]

{ #category : #tests }
DominoesTest >> test05_CanReverseDominoes [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(1 3 ) #(2 3 ) ) .
	self assert: result equals: true
]

{ #category : #tests }
DominoesTest >> test06_CantBeChained [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(4 1 ) #(2 3 ) ) .
	self assert: result equals: false
]

{ #category : #tests }
DominoesTest >> test07_DisconnectedSimple [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 1 ) #(2 2 ) ) .
	self assert: result equals: false
]

{ #category : #tests }
DominoesTest >> test08_DisconnectedDoubleLoop [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 1 ) #(3 4 ) #(4 3 ) ) .
	self assert: result equals: false
]

{ #category : #tests }
DominoesTest >> test09_DisconnectedSingleIsolated [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 3 ) #(3 1 ) #(4 4 ) ) .
	self assert: result equals: false
]

{ #category : #tests }
DominoesTest >> test10_NeedBacktrack [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 3 ) #(3 1 ) #(2 4 ) #(2 4 ) ) .
	self assert: result equals: true
]

{ #category : #tests }
DominoesTest >> test11_SeparateLoops [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(2 3 ) #(3 1 ) #(1 1 ) #(2 2 ) #(3 3 ) ) .
	self assert: result equals: true
]

{ #category : #tests }
DominoesTest >> test12_NineElements [
	| result |

	result := dominoesCalculator canChainDominoes: #(#(1 2 ) #(5 3 ) #(3 1 ) #(1 2 ) #(2 4 ) #(1 6 ) #(2 3 ) #(3 4 ) #(5 6 ) ) .
	self assert: result equals: true
]
