Extension { #name : 'Array' }

{ #category : '*Exercise@Minesweeper' }
Array >> mineAt: aPoint [
	(aPoint y < 1 or: [ aPoint y > self size ])
		ifTrue: [ ^ 0 ].
		
	(aPoint x < 1 or: [ aPoint x > self first size ])
		ifTrue: [ ^ 0 ].

	^ ((self at: aPoint y) at: aPoint x) asMinesweeperValue
]
