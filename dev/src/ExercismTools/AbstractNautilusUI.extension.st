Extension { #name : #AbstractNautilusUI }

{ #category : #'*ExercismTools' }
AbstractNautilusUI class >> packagesExercismMenu: aBuilder [
	<nautilusGlobalPackageMenu>
	| packageOrTag target packageTree |
	
	target := aBuilder model.
	(packageTree := target selectedPackage) ifNil: [ ^ target ].
	(packageTree packageName = 'Exercism') ifFalse: [ ^ target ].
	
	packageOrTag := packageTree item.
	
	(aBuilder item: #'Exercism')
		label: 'Exercism';
		order: 0;
		help: 'Exercism commands';
		withSeparatorAfter.
		
	(aBuilder item: #'Fetch Exercise...')
		parent: #'Exercism';
		action: [ ExercismManager default fetchFromExercismTo: packageOrTag ];
		order: 100;
		help: 'Fetch next Exercism example from exercism.io'.
	(aBuilder item: #'Submit Solution')
		parent: #'Exercism';
		action: [ ExercismManager default submitToExercism: packageOrTag ];
		order: 101;
		help: 'Submit a completed Exercism example to exercism.io'.
	(aBuilder item: #'View Track Progress')
		parent: #'Exercism';
		action: [ ExercismManager default viewOnExercism: packageOrTag ];
		order: 102;
		help: 'View the Pharo track on www.exercism.io'.
	(aBuilder item: #'View metadata')
		parent: #'Exercism';
		action: [ ((RPackageOrganizer default packageNamed: 'Exercism') ensureProperties at: packageOrTag)  inspect];
		order: 105;
		help: 'View Exercism solution metadata (maybe only during dev/debug).'.
]
