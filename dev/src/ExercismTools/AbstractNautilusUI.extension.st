Extension { #name : #AbstractNautilusUI }

{ #category : #'*ExercismTools' }
AbstractNautilusUI class >> packagesExercismMenu: aBuilder [
	<nautilusGlobalPackageMenu>
	| package target packageTree |
	
	target := aBuilder model.
	(packageTree := target selectedPackage) ifNil: [ ^ target ].
	(packageTree packageName = 'Exercism') ifFalse: [ ^ target ].
	
	package := packageTree item.
	
	(aBuilder item: #'Exercism')
		label: 'Exercism';
		order: 5000;
		help: 'Exercism commands'.
		
	(aBuilder item: #'Fetch Exercise...')
		parent: #'Exercism';
		action: [ ExercismManager default fetchFromExercismTo: package ];
		order: 100;
		help: 'Fetch next Exercism example from exercism.io'.
	(aBuilder item: #'Submit Solution')
		parent: #'Exercism';
		action: [ ExercismManager default submitToExercism: package ];
		order: 101;
		help: 'Submit a completed Exercism example to exercism.io'.
	(aBuilder item: #'View Track Progress')
		parent: #'Exercism';
		action: [ ExercismManager default viewOnExercism: package ];
		order: 102;
		help: 'View the Pharo track on www.exercism.io'.
	
]
