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
				package: 'ExercismPharo70'; "Pharo override/patch methods"
				package: 'ExercismTools' 
					with: [ spec requires: #('ExercismPharo70') ];
				
				package: 'Exercism'; "For dev group (as this has all solutions & tests)"
				
				package: 'ExercismMocking' 
					with: [ spec requires: #('Mocketry') ];
				package: 'ExercismTests'
					with: [ spec requires: #('ExercismMocking') ];
				package: 'ExercismSystemTests'
					with: [ spec requires: #('ExercismTests') ];
				
				package: 'ExercismWIP';
					
				package: 'ExercismDev'
					with: [ spec requires: #(
						'OSProcess' "For shelling out to configlet"
						'Ring2' "For mentoring support of shadow browsing"
						'ExercismTools' 'Exercism' 'ExercismWIP' 
						'ExercismTests' 'ExercismSystemTests'
						)];
				
				group: 'default'
					with: #('ExercismTools');
				
				group: 'dev'
					with: #('ExercismDev')]
]

{ #category : #baselines }
BaselineOfExercism >> projectClass [
	^ MetacelloCypressBaselineProject
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
    	baseline: 'Mocketry'
    	with: [ spec repository: 'github://dionisiydk/Mocketry:v4.0.x' ].
	
	spec
    	baseline: 'Ring2'
    	with: [ spec repository: 'github://pavel-krivanek/Ring2'; versionString: #calypso ].
]
