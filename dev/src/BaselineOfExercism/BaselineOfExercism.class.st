Class {
	#name : #BaselineOfExercism,
	#superclass : #BaselineOf,
	#category : #BaselineOfExercism
}

{ #category : #baselines }
BaselineOfExercism class >> exercisePackageNames [
	"Answer the list of exercise package names (as we don't yet have proper projects)"

	^ #('Exercise@Acronym' 'Exercise@Allergies' 'Exercise@Anagram' 'Exercise@ArmstrongNumbers' 'Exercise@AtbashCipher' 'Exercise@Binary' 'Exercise@Bowling' 'Exercise@Clock' 'Exercise@CollatzConjecture' 'Exercise@Darts' 'Exercise@Diamond' 'Exercise@Die' 'Exercise@Etl' 'Exercise@FlattenArray' 'Exercise@Forth' 'Exercise@GradeSchool' 'Exercise@Grains' 'Exercise@Hamming' 'Exercise@HelloWorld' 'Exercise@HighScores' 'Exercise@IsbnVerifier' 'Exercise@Isogram' 'Exercise@Leap' 'Exercise@Luhn' 'Exercise@MatchingBrackets' 'Exercise@Matrix' 'Exercise@Minesweeper' 'Exercise@Pangram' 'Exercise@Proverb' 'Exercise@Raindrops' 'Exercise@ResistorColorDuo' 'Exercise@ReverseString' 'Exercise@RobotSimulator' 'Exercise@RomanNumerals' 'Exercise@SecretHandshake' 'Exercise@Sieve' 'Exercise@SpaceAge' 'Exercise@SumOfMultiples' 'Exercise@Tournament' 'Exercise@TwelveDays' 'Exercise@TwoFer' 'Exercise@Welcome' 'Exercise@WordCount')
]

{ #category : #baselines }
BaselineOfExercism class >> exerciseTestPackageNames [
	"Answer the list of exercise package names used for testing (as we don't yet have proper projects)"

	^ #('ExercismTests-ExerciseEmpty' 'ExercismTests-ExerciseMany' 'ExercismTests-ExerciseNormal' 'ExercismTests-ExerciseExtension')
]

{ #category : #baselines }
BaselineOfExercism >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ self setExercismLogo.
			self setUpDependencies: spec.
			self setUpExercisesFor: spec.
			spec
				package: 'ExercismTools';
				
				package: 'ExercismMocking' 
					with: [ spec requires: #('Mocketry') ];
				package: 'ExercismTests'
					with: [ spec requires: #('ExercismTools' 'ExercismMocking'), 
						self class exerciseTestPackageNames ];
					
				package: 'ExercismSystemTests'
					with: [ spec requires: #('ExercismTests') ];
				
				package: 'ExercismWIP'
					with: [ spec requires: #('ExercismTools') ];
					
				package: 'ExercismDev'
					with: [ spec requires: #('ExercismTools'
							'OSSubprocess' 'OSWinSubprocess' "For shelling out to configlet"						
						 ),  
						self class exercisePackageNames ];
			
				package: 'ExercismV3';
				
				group: 'default'
					with: #('ExercismTools' 'Exercise@Welcome');
					
				group: 'mentor'
					with: #('ExercismDev' );
				
				group: 'dev'
					with: #('ExercismDev' 'ExercismWIP' 'ExercismSystemTests');
				
				group: 'v3'
					with: #('ExercismV3')].
		spec
			for: #'pharo7.x'
			do: [ 
				spec 
					package: 'ExercismPharo70'; "Pharo override/patch methods"
					package: 'ExercismTools' 
					with: [ spec requires: #('ExercismPharo70')];
					package: 'ExercismDev'
					with: [ spec requires: #(
						'Ring2' "For mentoring support of shadow browsing"
						)]
			].
]

{ #category : #baselines }
BaselineOfExercism >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfExercism >> setExercismLogo [
	| exercismLogo |
	exercismLogo := (AlphaImageMorph
		withForm:
		(ZnEasy
		getPng:
			'https://user-images.githubusercontent.com/38899847/48952150-634e9b80-eefe-11e8-890e-7a233d56df65.png'))
		layout: #scaledAspect;
		extent: 100 @ 100;
		position: 10 @ 135;
		lock.
	World addMorph: exercismLogo
]

{ #category : #baselines }
BaselineOfExercism >> setUpDependencies: spec [

	spec 
		baseline: 'OSSubprocess'
 		with: [spec repository: 'github://pharo-contributions/OSSubprocess:master/repository'].
	
	spec 
		baseline: 'OSWinSubprocess'
 		with: [spec repository: 'github://pharo-contributions/OSWinSubprocess:master/repository'].
					
	spec
    	baseline: 'Mocketry'
    	with: [ spec repository: 'github://pharo-exercism/Mocketry:v4.0.x' ].
	
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
