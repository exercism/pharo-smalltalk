Class {
	#name : #MatrixReader,
	#superclass : #Object,
	#category : #'Exercise@Matrix'
}

{ #category : #exercism }
MatrixReader >> input: aString atColumn: anInteger [
	^ (self parseLines: aString) collect: [ :l | l at: anInteger ]
]

{ #category : #exercism }
MatrixReader >> input: aString atRow: anInteger [
	^ (self parseLines: aString) at: anInteger
]

{ #category : #helper }
MatrixReader >> parseLines: aString [
	^ aString lines collect: [ :l | l parseLiterals ]
]
