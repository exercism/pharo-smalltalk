Extension { #name : #RPackageTag }

{ #category : #'*ExercismTools' }
RPackageTag >> definedClasses [
	^ self classes
]

{ #category : #'*ExercismTools' }
RPackageTag >> exerciseName [
	"Provided for legacy compatibility"
	^self name asString
]

{ #category : #'*ExercismTools' }
RPackageTag >> promoteAsExercismRPackage [
	"This method converts this rpackage tag into an rpackage compatible with exercism"
	|  tagName pkgName promotedName pkg |
	
	tagName := self name.
	pkgName := self packageName.
	promotedName := self categoryName.
	
	self promoteAsRPackage.
	
	pkg := RPackageOrganizer default packageNamed: promotedName.
	pkg renameTo: pkgName, '@', tagName
]

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
