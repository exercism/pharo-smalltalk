Extension { #name : #RGObject }

{ #category : #'*ExercismDev' }
RGObject >> summaryOn: aWriteStream [ 
	| text |
	text := self propertyNamed: #exercism ifAbsent: [ ^self ].
	
	text ifNotEmpty: [ 
	aWriteStream nextPut: $`.
	self printOn: aWriteStream.
	aWriteStream 
		nextPut: $`; lf; lf; 
		nextPutAll: text; lf; lf ]
]
