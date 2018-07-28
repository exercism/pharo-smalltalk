Extension { #name : #AbstractNautilusUI }

{ #category : #'*ExercismTools' }
AbstractNautilusUI class >> packagesExercismMenu: aBuilder [
	<contextMenu>
	<nautilusGlobalPackageMenu>
	| package target |
	target := aBuilder model.
	(package := target selectedPackage) ifNil: [ ^ target ].
	(package name beginsWith: 'Exercism') ifFalse: [ ^ target ].
	
	(aBuilder item: #'Exercism Submit')
		action: [ ExercismManager submitToExercism: package ];
		order: 2001;
		help: 'Submit a completed Exercism example to exercism.io'.
	(aBuilder item: #'Exercism Fetch Next')
		action: [ ExercismManager fetchFromExercismTo: package ];
		order: 2000;
		help: 'Fetch next Exercism example from exercism.io'.
	
	self packagesMenuGroupsItems: aBuilder
]
