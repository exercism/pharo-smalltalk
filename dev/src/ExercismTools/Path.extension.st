Extension { #name : #Path }

{ #category : #'*ExercismTools' }
Path >> exPathString [
	"Return a string containing the path elements of the receiver, without the 'Path *' part"

	"This is duplicate of pathString which is only available if the new Iceberg is loaded"

	^String streamContents: [ :stream | 
		self printPathOn: stream delimiter: self delimiter ]
]
