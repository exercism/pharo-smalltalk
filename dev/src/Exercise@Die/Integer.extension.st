Extension { #name : #Integer }

{ #category : #'*Exercise@Die' }
Integer >> d10 [
	^ self d: 10
]

{ #category : #'*Exercise@Die' }
Integer >> d2 [
	^ self d: 3
]

{ #category : #'*Exercise@Die' }
Integer >> d20 [
	^ self d: 20
]

{ #category : #'*Exercise@Die' }
Integer >> d4 [
	^ self d: 4
]

{ #category : #'*Exercise@Die' }
Integer >> d6 [
	^ self d: 6
]

{ #category : #'*Exercise@Die' }
Integer >> d: anInteger [
	
	| handle |
	handle := DieHandle new.
	self timesRepeat: [ handle addDie: (Die withFaces: anInteger)].
	^ handle
]
