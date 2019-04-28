Extension { #name : #RPackageTag }

{ #category : #'*ExercismTools' }
RPackageTag >> promoteAsExercismRPackage [
	"This method converts this rpackage tag into an rpackage, removes the tag from the parent package with all classes included and registers the new package in the system.
	The tag has to be removed before registering to avoid conflicts.
	Smells like we could have an error and lose package tags! registerPackage should not fail because names Package-Tag are unique in the system."
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
