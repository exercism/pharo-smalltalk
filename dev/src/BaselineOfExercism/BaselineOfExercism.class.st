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
				package: 'Exercism'
					with: [ ];
				package: 'ExercismDev'
					with: [ spec requires: #('Exercism' 'ExercismTools')];
				package: 'ExercismTools'
					with: [ spec requires: #('OSProcess' 'ExternalWebBrowser') ];
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
				
	spec
		baseline: 'ExternalWebBrowser'
			with: [ spec
				repository: 'github://seandenigris/Pharo-Web-Browser:master/repository' ];
		import: 'ExternalWebBrowser'.
		
]
