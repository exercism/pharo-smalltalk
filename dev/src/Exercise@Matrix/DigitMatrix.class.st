Class {
	#name : #DigitMatrix,
	#superclass : #Object,
	#category : #'Exercise@Matrix'
}

{ #category : #exercism }
DigitMatrix >> columnString: aString index: anInteger [
	^ (self parseLines: aString) collect: [ :l | l at: anInteger ]
]

{ #category : #helper }
DigitMatrix >> parseLines: aString [
	^ aString lines collect: [ :l | l parseLiterals ]
]

{ #category : #exercism }
DigitMatrix >> rowString: aString index: anInteger [
	^ (self parseLines: aString) at: anInteger
]
