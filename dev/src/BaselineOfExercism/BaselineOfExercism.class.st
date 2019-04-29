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
			self setUpExercisesFor: spec.
			spec
				package: 'ExercismPharo70'; "Pharo override/patch methods"
				package: 'ExercismTools' 
					with: [ spec requires: #('ExercismPharo70') ];
				
				package: 'ExercismMocking' 
					with: [ spec requires: #('Mocketry') ];
				package: 'ExercismTests'
					with: [ spec requires: #('ExercismTools' 'ExercismMocking'), 
						self exerciseTestPackageNames ];
				package: 'ExercismSystemTests'
					with: [ spec requires: #('ExercismTests') ];
				
				package: 'ExercismWIP'
					with: [ spec requires: #('ExercismTools') ];
					
				package: 'ExercismDev'
					with: [ spec requires: #(
						'OSProcess' "For shelling out to configlet"
						'Ring2' "For mentoring support of shadow browsing"
						'ExercismTools'),  
						self exercisePackageNames,
						#('ExercismWIP' 
						'ExercismTests' 
						'ExercismSystemTests')];
				
				group: 'default'
					with: #('ExercismTools' 'Exercism@Welcome');
				
				group: 'dev'
					with: #('ExercismDev')]
]

{ #category : #baselines }
BaselineOfExercism >> exercisePackageNames [
	"Answer the list of exercise package names (as we don't yet have proper projects)"

	^ #('Exercism@Acronym' 'Exercism@Allergies' 'Exercism@Anagram' 'Exercism@ArmstrongNumbers' 'Exercism@AtbashCipher' 'Exercism@Binary' 'Exercism@Bowling' 'Exercism@Clock' 'Exercism@CollatzConjecture' 'Exercism@Darts' 'Exercism@Diamond' 'Exercism@Etl' 'Exercism@Forth' 'Exercism@GradeSchool' 'Exercism@Grains' 'Exercism@Hamming' 'Exercism@HelloWorld' 'Exercism@HighScores' 'Exercism@IsbnVerifier' 'Exercism@Isogram' 'Exercism@Leap' 'Exercism@Luhn' 'Exercism@MatchingBrackets' 'Exercism@Pangram' 'Exercism@Proverb' 'Exercism@Raindrops' 'Exercism@ResistorColorDuo' 'Exercism@ReverseString' 'Exercism@RobotSimulator' 'Exercism@RomanNumerals' 'Exercism@SecretHandshake' 'Exercism@Sieve' 'Exercism@SpaceAge' 'Exercism@SumOfMultiples' 'Exercism@Tournament' 'Exercism@TwelveDays' 'Exercism@TwoFer' 'Exercism@Welcome' 'Exercism@WordCount')
]

{ #category : #baselines }
BaselineOfExercism >> exerciseTestPackageNames [
	"Answer the list of exercise package names used for testing (as we don't yet have proper projects)"

	^ #('ExercismTests-ExerciseEmpty' 'ExercismTests-ExerciseMany' 'ExercismTests-ExerciseNormal')
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
	self exercisePackageNames, self exerciseTestPackageNames 
		do:
			[ :name | spec package: name with: [ spec requires: #('ExercismTests') ] ]
]
