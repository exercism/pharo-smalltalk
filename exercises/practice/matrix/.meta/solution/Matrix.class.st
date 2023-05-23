Class {
	#name : #Matrix,
	#superclass : #Object,
	#category : #'Exercise@Matrix'
}

{ #category : #exercism }
Matrix >> input: aString atColumn: anInteger [
	^ (self parseLines: aString) collect: [ :l | l at: anInteger ]
]

{ #category : #exercism }
Matrix >> input: aString atRow: anInteger [
	^ (self parseLines: aString) at: anInteger
]

{ #category : #helper }
Matrix >> parseLines: aString [
	^ aString lines collect: [ :l | l parseLiterals ]
]
