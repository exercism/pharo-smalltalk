Extension { #name : #Integer }

{ #category : #'*Exercise@Die' }
Integer >> D10 [
	^ self D: 10
]

{ #category : #'*Exercise@Die' }
Integer >> D2 [
	^ self D: 3
]

{ #category : #'*Exercise@Die' }
Integer >> D20 [
	^ self D: 20
]

{ #category : #'*Exercise@Die' }
Integer >> D4 [
	^ self D: 4
]

{ #category : #'*Exercise@Die' }
Integer >> D6 [
	^ self D: 6
]

{ #category : #'*Exercise@Die' }
Integer >> D: anInteger [
	
	| handle |
	handle := DieHandle new.
	self timesRepeat: [ handle addDie: (Die withFaces: anInteger)].
	^ handle
]
