Extension { #name : 'RGPackageDefinition' }

{ #category : '*ExercismDev' }
RGPackageDefinition >> summaryOn: aWriteStream [ 
	| text |
	
	aWriteStream 
		nextPutAll: ('Exercise Feedback for: {1}' format: {self name});
		lf; lf.
		
	
	text  := self propertyNamed: #exercism ifAbsent: [ ^self ].
	
	text ifNotEmpty: [ 
	aWriteStream 
		nextPutAll: text; lf; lf ]
]
