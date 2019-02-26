Class {
	#name : #BaselineOfExercism,
	#superclass : #BaselineOf,
	#category : #BaselineOfExercism
}

{ #category : #baselines }
BaselineOfExercism >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec
				package: 'ExercismTools'
					with: [ ];
				package: 'Exercism'
					with: [ "Dev version (as this has all the solutons as well as tests)"];
				package: 'ExercismWIP'
					with: [ "Holding package for WIP tests"];
				package: 'ExercismDev'
					with: [ spec requires: #('ExercismTools' 'Exercism' 'ExercismWIP' 'OSProcess')];
				group: 'default'
					with:
					#('ExercismTools');
				group: 'dev'
					with:
					#('ExercismDev')]
]

{ #category : #baselines }
BaselineOfExercism >> setUpDependencies: spec [

	spec 
		configuration: 'OSProcess' 
			with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://www.squeaksource.com/OSProcess' ].
		
]
