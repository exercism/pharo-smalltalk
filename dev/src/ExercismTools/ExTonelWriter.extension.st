Extension { #name : #ExTonelWriter }

{ #category : #'*ExercismTools' }
ExTonelWriter >> mappedSnapshot: aSnapshot [
	"extracted from #writeSnapshot: to customise behavior"
	
	|tonelMap extensionDefinitions|
	snapshot := aSnapshot.
	tonelMap := Dictionary new.
		
	"Tonel export classes with their methods, mapped from their filename to content streams"
	(snapshot definitions select: #isClassDefinition)
		do: [ :classDef |  |filename tonelStream|
			filename := classDef exTonelFilename.
			tonelStream := WriteStream on: String new.
	 		self writeClass: classDef on: tonelStream.
	  		tonelMap at: filename put: tonelStream ].
	
	"... and method extensions"
	extensionDefinitions := (snapshot definitions select: [ :each | 
		each isMethodDefinition and: [ each isExtensionMethod ] ]) removeDuplicates.

	extensionDefinitions do: [ :methodDef | |filename|
		filename := methodDef exTonelFilename.
		tonelMap at: filename ifAbsentPut: [ 
			(WriteStream on: String new) nextPutAll: 'Extension { #name : #', methodDef className, ' }' ; lf; yourself ].
		self writeMethodDefinition: methodDef on: (tonelMap at: filename). 
		].
	^tonelMap

]

{ #category : #'*ExercismTools' }
ExTonelWriter >> writeClass: aClassDefinition on: aStream [
	"Not clear on whether this is an override and still needed? ~tma~"
	
	self writeClassDefinition: aClassDefinition on: aStream.
	self writeClassSideMethodDefinitions: aClassDefinition on: aStream.
	self writeInstanceSideMethodDefinitions: aClassDefinition on: aStream 
]
