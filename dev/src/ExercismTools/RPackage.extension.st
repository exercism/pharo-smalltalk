Extension { #name : #RPackage }

{ #category : #'*ExercismTools' }
RPackage >> exPrintOutExtensionsFor: aClass on: aWriteStream [

	| selectors |
	(selectors := self extensionSelectorsForClass: aClass) ifEmpty: [  ^self ].
	
	aWriteStream 
		nextPutAll: '"-- #'; 
		nextPutAll: aClass name; 
		nextPutAll: ' (extension) --"'; 
		cr; cr.
	
	selectors do: [ :sel |  
		aClass exPrintOutMethod: sel on: aWriteStream ]
]

{ #category : #'*ExercismTools' }
RPackage >> exerciseName [
	^ (self name allRegexMatches: '\w+') last
]

{ #category : #'*ExercismTools' }
RPackage >> root [
	^self
]

{ #category : #'*ExercismTools' }
RPackage >> snapshot [
	| pkgSnapshot extensions |
	pkgSnapshot := (MCPackage named: self name) snapshot.
	
	extensions := self extensionMethods
		collect: [ :extension | extension asRingDefinition asMCMethodDefinition  ].
		
	^ MCSnapshot fromDefinitions: pkgSnapshot definitions , extensions
]
