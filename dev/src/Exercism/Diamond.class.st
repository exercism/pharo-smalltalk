Class {
	#name : #Diamond,
	#superclass : #Object,
	#category : #'Exercism-Diamond'
}

{ #category : #accessing }
Diamond >> rowsLetter: aString [
	| diamondLetters topHalfOfDiamond bottomHalfOfDiamond |
	self
		assert: aString notEmpty;
		assert: aString size = 1.
	diamondLetters := DiamondLetter createAllFromCharacter: aString first.
	topHalfOfDiamond := diamondLetters collect: #displayString.
	bottomHalfOfDiamond := topHalfOfDiamond reversed allButFirst.
	^ (topHalfOfDiamond , bottomHalfOfDiamond) asArray
]
