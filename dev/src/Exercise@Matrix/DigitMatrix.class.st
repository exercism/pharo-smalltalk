Class {
	#name : #DigitMatrix,
	#superclass : #Object,
	#category : #'Exercise@Matrix'
}

{ #category : #exercism }
DigitMatrix >> input: aString atColumn: anInteger [
	^ (self parseLines: aString) collect: [ :l | l at: anInteger ]
]

{ #category : #exercism }
DigitMatrix >> input: aString atRow: anInteger [
	^ (self parseLines: aString) at: anInteger
]

{ #category : #helper }
DigitMatrix >> parseLines: aString [
	^ aString lines collect: [ :l | l parseLiterals ]
]
