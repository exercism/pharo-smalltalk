Extension { #name : #TonelParser }

{ #category : #'*ExercismTools' }
TonelParser >> documentFrom: aString [
	self stream: aString readStream.
	^self document
]
