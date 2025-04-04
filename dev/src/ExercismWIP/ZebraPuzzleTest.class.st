"
# Zebra Puzzle

Solve the zebra puzzle.

1. There are five houses.
2. The Englishman lives in the red house.
3. The Spaniard owns the dog.
4. Coffee is drunk in the green house.
5. The Ukrainian drinks tea.
6. The green house is immediately to the right of the ivory house.
7. The Old Gold smoker owns snails.
8. Kools are smoked in the yellow house.
9. Milk is drunk in the middle house.
10. The Norwegian lives in the first house.
11. The man who smokes Chesterfields lives in the house next to the man with the fox.
12. Kools are smoked in the house next to the house where the horse is kept.
13. The Lucky Strike smoker drinks orange juice.
14. The Japanese smokes Parliaments.
15. The Norwegian lives next to the blue house.

Each of the five houses is painted a different color, and their
inhabitants are of different national extractions, own different pets,
drink different beverages and smoke different brands of cigarettes.

Which of the residents drinks water?
Who owns the zebra?

## Hint

TBD

"
Class {
	#name : 'ZebraPuzzleTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'zebraPuzzleCalculator'
	],
	#category : 'ExercismWIP-ZebraPuzzle',
	#package : 'ExercismWIP',
	#tag : 'ZebraPuzzle'
}

{ #category : 'config' }
ZebraPuzzleTest class >> uuid [
	"Answer a unique id for this exercise"
	^'5aa20717-9d41-0d00-9012-879708866539'
]

{ #category : 'config' }
ZebraPuzzleTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : 'running' }
ZebraPuzzleTest >> setUp [
	super setUp.
	zebraPuzzleCalculator := ZebraPuzzle new
]

{ #category : 'tests' }
ZebraPuzzleTest >> test01_ResidentWhoDrinksWater [
	| result |

	result := zebraPuzzleCalculator drinksWater.
	self assert: result equals: 'Norwegian'
]

{ #category : 'tests' }
ZebraPuzzleTest >> test02_ResidentWhoOwnsZebra [
	| result |

	result := zebraPuzzleCalculator ownsZebra.
	self assert: result equals: 'Japanese'
]
