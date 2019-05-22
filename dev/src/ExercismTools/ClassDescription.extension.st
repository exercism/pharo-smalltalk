Extension { #name : #ClassDescription }

{ #category : #'*ExercismTools' }
ClassDescription >> exPrintOutCategoriesFor: aClass on: aWriteStream [

	aClass methods ifEmpty: [ ^self ].
	
	aWriteStream 
		nextPutAll: (aClass isClassSide ifTrue: [ '"[class'] ifFalse: [  '"[instance']);
	 	nextPutAll: ' methods]"'; cr.
	
	aClass organization categories asSortedCollection 
		do: [ :heading | 
			aWriteStream
				nextPutAll: '"category: ';
				nextPutAll: heading;
				nextPutAll: '"';
				cr.
				
			aClass exPrintOutLocalMethodsInCategory: heading on: aWriteStream ]
]

{ #category : #'*ExercismTools' }
ClassDescription >> exPrintOutExtensionsFor: aRPackage on: aWriteStream [

	aRPackage exPrintOutExtensionsFor: self on: aWriteStream. 
]

{ #category : #'*ExercismTools' }
ClassDescription >> exPrintOutLocalMethodsInCategory: aSymbol on: aWriteStream [
	"Print out methods for this category."

	aWriteStream cr.
	
	(self selectorsToFileOutCategory: aSymbol)
		do: [ :sel | self exPrintOutMethod: sel on: aWriteStream ]
	
]

{ #category : #'*ExercismTools' }
ClassDescription >> exPrintOutMethod: selector on: aWriteStream [
	"Print the source code for selector onto the WriteStream."

	| method source |
	method := self
		compiledMethodAt: selector
		ifAbsent: [ ^ aWriteStream
				nextPutAll: selector;
				cr;
				tab;
				nextPutAll: '"** ERROR: SOURCE IS MISSING ** ".';
				cr;
				cr ].
			
	source := method sourceCode trimBoth.
	
	aWriteStream nextPutAll: source.
	
	source last = $.
		ifFalse: [ aWriteStream nextPut: $. ].
		
	aWriteStream
		cr;
		cr
]

{ #category : #'*ExercismTools' }
ClassDescription >> exPrintOutOn: aWriteStream [
	"Print a description of the receiver on aWriteStream."

	aWriteStream
		nextPutAll: '"-- #', self name, ' (class) --"'; cr; cr;
		nextPutAll: self definition; 
		nextPut: $.; cr; cr.
	
	self hasComment ifTrue: [ 
		aWriteStream nextPut: $".
		self comment trimBoth encodeDoublingDoubleQuotesOn: aWriteStream.
		aWriteStream nextPut: $"; cr; cr ].
	
	self exPrintOutCategoriesFor: self class on: aWriteStream.
	self exPrintOutCategoriesFor: self on: aWriteStream
]

{ #category : #'*ExercismTools' }
ClassDescription class >> exTonelClassFilenameFor: aName [
	^aName, '.class.st'
]

{ #category : #'*ExercismTools' }
ClassDescription class >> exTonelExtensionFilenameFor: aName [
	^aName, '.extension.st'
]
