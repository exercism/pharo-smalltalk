Extension { #name : 'Character' }

{ #category : '*Exercise@Minesweeper' }
Character >> asMinesweeperValue [
	^self = $* ifTrue: [ 1 ] ifFalse: [ 0 ]
]
