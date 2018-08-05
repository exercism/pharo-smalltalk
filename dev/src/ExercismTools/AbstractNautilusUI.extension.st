Extension { #name : #AbstractNautilusUI }

{ #category : #'*ExercismTools' }
AbstractNautilusUI class >> packagesExercismMenu: aBuilder [
	<nautilusGlobalPackageMenu>
	| package target |
	target := aBuilder model.
	(package := target selectedPackage) ifNil: [ ^ target ].
	((package name beginsWith: 'Exercism') or: [ package package name beginsWith: 'Exercism' ]) ifFalse: [ ^ target ].
	
	(aBuilder item: #'Exercism')
		label: 'Exercism...';
		order: 3000;
		help: 'Exercism commands'.
		
	(aBuilder item: #'Fetch Next')
		parent: #'Exercism';
		action: [ ExercismManager fetchFromExercismTo: package ];
		order: 3000;
		help: 'Fetch next Exercism example from exercism.io'.
	(aBuilder item: #'Submit')
		parent: #'Exercism';
		action: [ ExercismManager submitToExercism: package ];
		order: 3001;
		help: 'Submit a completed Exercism example to exercism.io'.
	(aBuilder item: #'View')
		parent: #'Exercism';
		action: [ ExercismManager viewOnExercism: package ];
		order: 3002;
		help: 'View an Exercism example on exercism.io'.
	
]
