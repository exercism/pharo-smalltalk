Extension { #name : #AbstractNautilusUI }

{ #category : #'*ExercismDev' }
AbstractNautilusUI class >> packagesExercismMenuGenerate: aBuilder [
	<nautilusGlobalPackageMenu>
	| target packageTree |
	
	target := aBuilder model.
	(packageTree := target selectedPackage) ifNil: [ ^ target ].
	(packageTree packageName = 'Exercism') ifFalse: [ ^ target ].
	
	(aBuilder item: #'Generate Exercises...')
		parent: #'Exercism';
		action: [ ExercismGenerator generate ];
		order: 50;
		withSeparatorAfter;
		help: 'Generate the Exercism templates into an existing git repository'.
	
]
