Extension { #name : #RPackageTag }

{ #category : #'*ExercismTools' }
RPackageTag >> root [
	^self package
]

{ #category : #'*ExercismTools' }
RPackageTag >> snapshot [
	| parentSnapshot |
	
	parentSnapshot := (MCPackage named: self package name) snapshot.
	
	^ MCSnapshot
		fromDefinitions:
			(parentSnapshot definitions
				select:
					[ :mc | mc className isNil or: [ mc actualClass category endsWith: self name ] ])
]
