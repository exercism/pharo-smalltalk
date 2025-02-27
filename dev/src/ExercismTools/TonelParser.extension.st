Extension { #name : 'TonelParser' }

{ #category : '*ExercismTools' }
TonelParser >> documentFrom: aString [
	self stream: aString readStream.
	^self document
]

{ #category : '*ExercismTools' }
TonelParser >> try: aBlock onSuccess: successBlock onFailure: failureBlock [
	| pos |

	pos := stream position.
	[ ^ successBlock value: aBlock value ]
	on: TonelParseError
	do: [ :e |
		stream position > pos ifTrue: [stream position: pos].
		^ failureBlock value ].

]
