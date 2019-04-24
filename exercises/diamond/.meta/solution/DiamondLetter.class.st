Class {
	#name : #DiamondLetter,
	#superclass : #Object,
	#instVars : [
		'character',
		'rowNumber',
		'diamondSize'
	],
	#category : #'Exercism-Diamond'
}

{ #category : #'instance creation' }
DiamondLetter class >> createAllFromCharacter: aCharacter [
	^ self createFrom: ($A to: aCharacter)
]

{ #category : #'instance creation' }
DiamondLetter class >> createFrom: characters [
	^ characters
		collectWithIndex: [ :aCharacter :index | 
			DiamondLetter new
				setCharacter: aCharacter
				row: index
				diamondSize: characters size ]
]

{ #category : #'private - displaying' }
DiamondLetter >> characterWithSpacingOn: aStream [
	self middleSpacing = 0
		ifTrue: [ aStream nextPut: character.
			^ self ].
	aStream nextPut: character.
	self middleSpacing timesRepeat: [ aStream space ].
	aStream nextPut: character
]

{ #category : #private }
DiamondLetter >> cornerSpacing [
	^ diamondSize - rowNumber
]

{ #category : #'private - displaying' }
DiamondLetter >> cornerSpacingAround: aBlock on: aStream [
	self cornerSpacing timesRepeat: [ aStream space ].
	aBlock value.
	self cornerSpacing timesRepeat: [ aStream space ]
]

{ #category : #displaying }
DiamondLetter >> displayStringOn: aStream [
	self
		cornerSpacingAround: [ self characterWithSpacingOn: aStream ]
		on: aStream
]

{ #category : #private }
DiamondLetter >> middleSpacing [
	^ rowNumber - 1 + (rowNumber - 2 max: 0)
]

{ #category : #private }
DiamondLetter >> setCharacter: aCharacter row: aNumber diamondSize: size [
	character := aCharacter.
	rowNumber := aNumber.
	diamondSize := size
]
