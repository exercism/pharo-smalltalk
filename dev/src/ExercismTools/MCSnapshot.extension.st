Extension { #name : 'MCSnapshot' }

{ #category : '*ExercismTools' }
MCSnapshot >> classDefinitions [

	^ self definitions select: #isClassDefinition
]

{ #category : '*ExercismTools' }
MCSnapshot >> extensionDefinitions [

	^ (self definitions select: [ :each |
		   each isMethodDefinition and: [ each isExtensionMethod ] ])
		  removeDuplicates
]
