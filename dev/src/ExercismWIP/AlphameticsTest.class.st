"
# Alphametics

Write a function to solve alphametics puzzles.

[Alphametics](https://en.wikipedia.org/wiki/Alphametics) is a puzzle where
letters in words are replaced with numbers.

For example `SEND + MORE = MONEY`:

```text
  S E N D
  M O R E +
-----------
M O N E Y
```

Replacing these with valid numbers gives:

```text
  9 5 6 7
  1 0 8 5 +
-----------
1 0 6 5 2
```

This is correct because every letter is replaced by a different number and the
words, translated into numbers, then make a valid sum.

Each letter must represent a different digit, and the leading digit of
a multi-digit number must not be zero.

Write a function to solve alphametics puzzles.

## Hint

TBD

"
Class {
	#name : #AlphameticsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'alphameticsCalculator'
	],
	#category : #'ExercismWIP-Alphametics'
}

{ #category : #config }
AlphameticsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'a041d8bb-8040-0d00-811e-e9ed01deb008'
]

{ #category : #config }
AlphameticsTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.3.0'
]

{ #category : #setup }
AlphameticsTest >> setUp [
	alphameticsCalculator := Alphametics new
]

{ #category : #tests }
AlphameticsTest >> test01_SolveTheAlphameticsPuzzlePuzzleWithThreeLetters [
	| result |

	result := alphameticsCalculator solvePuzzle: 'I + BB == ILL' .
	self assert: result equals: ((Dictionary new) add: ('L'->0); add: ('I'->1); add: ('B'->9); yourself)
]

{ #category : #tests }
AlphameticsTest >> test02_SolveTheAlphameticsPuzzleSolutionMustHaveUniqueValueForEachLetter [
	| result |

	result := alphameticsCalculator solvePuzzle: 'A == B' .
	self assert: result equals: nil
]

{ #category : #tests }
AlphameticsTest >> test03_SolveTheAlphameticsPuzzleLeadingZeroSolutionIsInvalid [
	| result |

	result := alphameticsCalculator solvePuzzle: 'ACA + DD == BD' .
	self assert: result equals: nil
]

{ #category : #tests }
AlphameticsTest >> test04_SolveTheAlphameticsPuzzlePuzzleWithTwoDigitsFinalCarry [
	| result |

	result := alphameticsCalculator solvePuzzle: 'A + A + A + A + A + A + A + A + A + A + A + B == BCC' .
	self assert: result equals: ((Dictionary new) add: ('C'->0); add: ('A'->9); add: ('B'->1); yourself)
]

{ #category : #tests }
AlphameticsTest >> test05_SolveTheAlphameticsPuzzlePuzzleWithFourLetters [
	| result |

	result := alphameticsCalculator solvePuzzle: 'AS + A == MOM' .
	self assert: result equals: ((Dictionary new) add: ('O'->0); add: ('S'->2); add: ('A'->9); add: ('M'->1); yourself)
]

{ #category : #tests }
AlphameticsTest >> test06_SolveTheAlphameticsPuzzlePuzzleWithSixLetters [
	| result |

	result := alphameticsCalculator solvePuzzle: 'NO + NO + TOO == LATE' .
	self assert: result equals: ((Dictionary new) add: ('A'->0); add: ('O'->4); add: ('T'->9); add: ('N'->7); add: ('L'->1); add: ('E'->2); yourself)
]

{ #category : #tests }
AlphameticsTest >> test07_SolveTheAlphameticsPuzzlePuzzleWithSevenLetters [
	| result |

	result := alphameticsCalculator solvePuzzle: 'HE + SEES + THE == LIGHT' .
	self assert: result equals: ((Dictionary new) add: ('G'->2); add: ('S'->9); add: ('H'->5); add: ('T'->7); add: ('I'->0); add: ('L'->1); add: ('E'->4); yourself)
]

{ #category : #tests }
AlphameticsTest >> test08_SolveTheAlphameticsPuzzlePuzzleWithEightLetters [
	| result |

	result := alphameticsCalculator solvePuzzle: 'SEND + MORE == MONEY' .
	self assert: result equals: ((Dictionary new) add: ('S'->9); add: ('O'->0); add: ('M'->1); add: ('D'->7); add: ('R'->8); add: ('N'->6); add: ('Y'->2); add: ('E'->5); yourself)
]

{ #category : #tests }
AlphameticsTest >> test09_SolveTheAlphameticsPuzzlePuzzleWithTenLetters [
	| result |

	result := alphameticsCalculator solvePuzzle: 'AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE' .
	self assert: result equals: ((Dictionary new) add: ('D'->3); add: ('F'->7); add: ('R'->1); add: ('O'->2); add: ('T'->9); add: ('E'->4); add: ('N'->0); add: ('G'->8); add: ('S'->6); add: ('A'->5); yourself)
]

{ #category : #tests }
AlphameticsTest >> test10_SolveTheAlphameticsPuzzlePuzzleWithTenLettersAnd199Addends [
	| result |

	result := alphameticsCalculator solvePuzzle: 'THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES' .
	self assert: result equals: ((Dictionary new) add: ('I'->7); add: ('F'->5); add: ('R'->3); add: ('O'->6); add: ('L'->2); add: ('H'->8); add: ('T'->9); add: ('E'->0); add: ('S'->4); add: ('A'->1); yourself)
]
