Class {
	#name : #BaselineOfExercism,
	#superclass : #BaselineOf,
	#category : #BaselineOfExercism
}

{ #category : #baselines }
BaselineOfExercism class >> exercisePackageNames [
	"Answer the list of exercise package names (as we don't yet have proper projects)"

	^ #('Exercise@Acronym' 'Exercise@Allergies' 'Exercise@Anagram' 'Exercise@ArmstrongNumbers' 'Exercise@AtbashCipher' 'Exercise@Binary' 'Exercise@Bowling' 'Exercise@Clock' 'Exercise@CollatzConjecture' 'Exercise@Darts' 'Exercise@Diamond' 'Exercise@Die' 'Exercise@Etl' 'Exercise@Forth' 'Exercise@GradeSchool' 'Exercise@Grains' 'Exercise@Hamming' 'Exercise@HelloWorld' 'Exercise@HighScores' 'Exercise@IsbnVerifier' 'Exercise@Isogram' 'Exercise@Leap' 'Exercise@Luhn' 'Exercise@MatchingBrackets' 'Exercise@Pangram' 'Exercise@Proverb' 'Exercise@Raindrops' 'Exercise@ResistorColorDuo' 'Exercise@ReverseString' 'Exercise@RobotSimulator' 'Exercise@RomanNumerals' 'Exercise@SecretHandshake' 'Exercise@Sieve' 'Exercise@SpaceAge' 'Exercise@SumOfMultiples' 'Exercise@Tournament' 'Exercise@TwelveDays' 'Exercise@TwoFer' 'Exercise@Welcome' 'Exercise@WordCount')
]

{ #category : #baselines }
BaselineOfExercism class >> exerciseTestPackageNames [
	"Answer the list of exercise package names used for testing (as we don't yet have proper projects)"

	^ #('ExercismTests-ExerciseEmpty' 'ExercismTests-ExerciseMany' 'ExercismTests-ExerciseNormal')
]

{ #category : #baselines }
BaselineOfExercism >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			self setUpExercisesFor: spec.
			spec
				package: 'ExercismPharo70'; "Pharo override/patch methods"
				package: 'ExercismTools' 
					with: [ spec requires: #('ExercismPharo70') ];
				
				package: 'ExercismMocking' 
					with: [ spec requires: #('Mocketry') ];
				package: 'ExercismTests'
					with: [ spec requires: #('ExercismTools' 'ExercismMocking'), 
						self class exerciseTestPackageNames ];
					
				package: 'ExercismSystemTests'
					with: [ spec requires: #('ExercismTests') ];
				
				package: 'Exercism' "Legacy Package for Testing"
					with: [ spec requires: #('ExercismTools') ];
					
				package: 'ExercismWIP'
					with: [ spec requires: #('ExercismTools') ];
					
				package: 'ExercismDev'
					with: [ spec requires: #(
						'OSProcess' "For shelling out to configlet"
						'Ring2' "For mentoring support of shadow browsing"
						'ExercismTools' ),  
						self class exercisePackageNames,
						#('ExercismWIP' 
						'ExercismTests' 
						'ExercismSystemTests')];
				
				group: 'default'
					with: #('ExercismTools' 'Exercise@Welcome');
				
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
    	with: [ spec repository: 'github://pavel-krivanek/Ring2'; loads: #(calypso)].
]

{ #category : #baselines }
BaselineOfExercism >> setUpExercisesFor: spec [
	self class exercisePackageNames, self class exerciseTestPackageNames 
		do:
			[ :name | spec package: name with: [ spec requires: #('ExercismTools') ] ]
]
