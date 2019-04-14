Extension { #name : #MCSnapshot }

{ #category : #'*ExercismDev' }
MCSnapshot >> asExRingDefinitionIn: anRGEnvironment [
	| pkgName sysPkg rgPkg |
	
	pkgName := self definitions
		detect: [ :def | def isClassDefinition ]
		ifFound: [ :def | def category ]
		ifNone: [ #Undefined ].
		
	rgPkg := RGPackageDefinition named: pkgName parent: anRGEnvironment.
	sysPkg := RGPackageDefinition named: #System parent: anRGEnvironment.
	
	
	self definitions 
		select: [ :def | def isClassDefinition ] 
		thenDo: [ :cls | cls actualClass ifNotNil: [ :clz | 
				clz allSuperclasses reverseDo: [ :sc | 
					(sc ensureRingDefinitionIn: anRGEnvironment) package: sysPkg ] ] ].
		
		
	self exEnsureRingDefinitionIn: anRGEnvironment package: rgPkg.
	^anRGEnvironment 
	
]

{ #category : #'*ExercismDev' }
MCSnapshot >> asExRingEnvironment [
	^self asExRingDefinitionIn: RGEnvironment new.
	
]

{ #category : #'*ExercismDev' }
MCSnapshot >> exEnsureRingDefinitionIn: anRGEnvironment package: anRGPackageDefinition [

	anRGEnvironment announcer
		suspendAllWhile: [ 
			self definitions
				do: [ :each | 
					each
						ensureRingDefinitionIn: anRGEnvironment
						package: anRGPackageDefinition ]
				displayingProgress: 'Processing snapshot...' ].
			
	anRGEnvironment clean.
	anRGEnvironment
		behaviorsDo: [ :behavior | 
			behavior superclass == behavior
				ifTrue: [ behavior superclass: nil ] ]
]
