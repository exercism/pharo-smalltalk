"
# Go Counting

Count the scored points on a Go board.

In the game of go (also known as baduk, igo, cờ vây and wéiqí) points
are gained by completely encircling empty intersections with your
stones. The encircled intersections of a player are known as its
territory.

Write a function that determines the territory of each player. You may
assume that any stones that have been stranded in enemy territory have
already been taken off the board.

Write a function that determines the territory which includes a specified coordinate.

Multiple empty intersections may be encircled at once and for encircling
only horizontal and vertical neighbours count. In the following diagram
the stones which matter are marked ""O"" and the stones that don't are
marked ""I"" (ignored).  Empty spaces represent empty intersections.

```text
+----+
|IOOI|
|O  O|
|O OI|
|IOI |
+----+
```

To be more precise an empty intersection is part of a player's territory
if all of its neighbours are either stones of that player or empty
intersections that are part of that player's territory.

For more information see
[wikipedia](https://en.wikipedia.org/wiki/Go_%28game%29) or [Sensei's
Library](http://senseis.xmp.net/).

## Hint

TBD

"
Class {
	#name : #GoCountingTest,
	#superclass : #ExercismTest,
	#instVars : [
		'goCountingCalculator'
	],
	#category : #'ExercismWIP-GoCounting'
}

{ #category : #config }
GoCountingTest class >> uuid [
	"Answer a unique id for this exercise"
	^'60e363be-4a3f-0d00-bb42-8077071d6982'
]

{ #category : #config }
GoCountingTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.0.0'
]

{ #category : #setup }
GoCountingTest >> setUp [
	goCountingCalculator := GoCounting new
]

{ #category : #tests }
GoCountingTest >> test01_BlackCornerTerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 0 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#(#(0 0 ) #(0 1 ) #(1 0 ) )); add: ('owner'->'BLACK'); yourself)
]

{ #category : #tests }
GoCountingTest >> test02_WhiteCenterTerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 2 y: 3 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#(#(2 3 ) )); add: ('owner'->'WHITE'); yourself)
]

{ #category : #tests }
GoCountingTest >> test03_OpenCornerTerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y: 4 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#(#(0 3 ) #(0 4 ) #(1 4 ) )); add: ('owner'->'NONE'); yourself)
]

{ #category : #tests }
GoCountingTest >> test04_AStoneAndNotATerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#()); add: ('owner'->'NONE'); yourself)
]

{ #category : #tests }
GoCountingTest >> test05_InvalidBecauseXIsTooLowFor5x5Board [
	| result |

	result := goCountingCalculator territoryX:  -1 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #tests }
GoCountingTest >> test06_InvalidBecauseXIsTooHighFor5x5Board [
	| result |

	result := goCountingCalculator territoryX: 5 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #tests }
GoCountingTest >> test07_InvalidBecauseYIsTooLowFor5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y:  -1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #tests }
GoCountingTest >> test08_InvalidBecauseYIsTooHighFor5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y: 5 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #tests }
GoCountingTest >> test09_OneTerritoryIsTheWholeBoard [
	| result |

	result := goCountingCalculator territoriesBoard: #(' ' ) .
	self assert: result equals: ((Dictionary new) add: ('territoryWhite'->#()); add: ('territoryBlack'->#()); add: ('territoryNone'->#(#(0 0 ) )); yourself)
]

{ #category : #tests }
GoCountingTest >> test10_TwoTerritoryRectangularBoard [
	| result |

	result := goCountingCalculator territoriesBoard: #(' BW ' ' BW ' ) .
	self assert: result equals: ((Dictionary new) add: ('territoryWhite'->#(#(3 0 ) #(3 1 ) )); add: ('territoryBlack'->#(#(0 0 ) #(0 1 ) )); add: ('territoryNone'->#()); yourself)
]

{ #category : #tests }
GoCountingTest >> test11_TwoRegionRectangularBoard [
	| result |

	result := goCountingCalculator territoriesBoard: #(' B ' ) .
	self assert: result equals: ((Dictionary new) add: ('territoryWhite'->#()); add: ('territoryBlack'->#(#(0 0 ) #(2 0 ) )); add: ('territoryNone'->#()); yourself)
]
