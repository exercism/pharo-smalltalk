Extension { #name : #Integer }

{ #category : #'*Exercise@Minesweeper' }
Integer >> asMinesweeperChar [
	^ self = 0
		ifTrue: [ Character space ]
		ifFalse: [ self asCharacterDigit ]
]
