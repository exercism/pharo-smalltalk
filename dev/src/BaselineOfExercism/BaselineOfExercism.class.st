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
				package: 'XercismTools'
					with: [ spec requires: #('OSProcess' ) ];
				group: 'default'
					with:
					#('Exercism' 'XercismTools') ]
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
