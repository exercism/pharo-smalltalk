Extension { #name : #RPackage }

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
