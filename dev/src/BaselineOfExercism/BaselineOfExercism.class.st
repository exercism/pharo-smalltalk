"
Project baseline to load entire Exercism Pharo track, including all its dependencies
"
Class {
	#name : 'BaselineOfExercism',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfExercism',
	#package : 'BaselineOfExercism'
}

{ #category : 'baselines' }
BaselineOfExercism class >> exerciseGoldenTestPackageNames [
	"Answer the list of exercise package names used for golden tests executed by Exercism's test runner"

	^ #('Exercise@ExampleAllFail' 'Exercise@ExampleAllPass' 'Exercise@ExampleAllRaiseError' 'Exercise@ExampleEmptySolutionClass' 'Exercise@ExampleEmptySolutionFile' 'Exercise@ExampleErrorFailPass' 'Exercise@ExampleExtensionMethod' 'Exercise@ExampleSyntaxError' 'Exercise@ExampleTypoInMethodName')
]

{ #category : 'baselines' }
BaselineOfExercism class >> exercisePackageNames [
	"Answer the list of exercise package names (as we don't yet have proper projects)"

	^ #('Exercise@Acronym' 'Exercise@Allergies' 'Exercise@Anagram' 'Exercise@ArmstrongNumbers' 'Exercise@AtbashCipher' 'Exercise@Binary' 'Exercise@BinarySearchTree' 'Exercise@Bowling' 'Exercise@CircularBuffer' 'Exercise@Clock' 'Exercise@CollatzConjecture' 'Exercise@Darts' 'Exercise@Diamond' 'Exercise@Die' 'Exercise@Etl' 'Exercise@FlattenArray' 'Exercise@Forth' 'Exercise@GradeSchool' 'Exercise@Grains' 'Exercise@Hamming' 'Exercise@HelloWorld' 'Exercise@HighScores' 'Exercise@IsbnVerifier' 'Exercise@Isogram' 'Exercise@Leap' 'Exercise@Luhn' 'Exercise@MatchingBrackets' 'Exercise@Matrix' 'Exercise@Minesweeper' 'Exercise@Pangram' 'Exercise@Proverb' 'Exercise@Raindrops' 'Exercise@ResistorColorDuo' 'Exercise@ReverseString' 'Exercise@RobotSimulator' 'Exercise@RomanNumerals' 'Exercise@SecretHandshake' 'Exercise@Sieve' 'Exercise@SimpleCipher' 'Exercise@SpaceAge' 'Exercise@SumOfMultiples' 'Exercise@Tournament' 'Exercise@TwelveDays' 'Exercise@TwoFer' 'Exercise@Welcome' 'Exercise@WordCount')
]

{ #category : 'baselines' }
BaselineOfExercism class >> exerciseTestPackageNames [
	"Answer the list of exercise package names used for testing (as we don't yet have proper projects)"

	^ #('ExercismTests-ExerciseEmpty' 'ExercismTests-ExerciseMany' 'ExercismTests-ExerciseNormal' 'ExercismTests-ExerciseExtension')
]

{ #category : 'baselines' }
BaselineOfExercism >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self setExercismLogo.
			self setUpDependencies: spec.
			self setUpExercisesFor: spec.
			self setUpGoldenTestsFor: spec.
			spec
				package: 'ExercismTools';
				package: 'ExercismMocking' with: [ spec requires: #('Mocketry') ];
				package: 'ExercismTests'
					with: [ spec
						requires:
							#('ExercismTools' 'ExercismMocking')
								, self class exerciseTestPackageNames ];
				package: 'ExercismSystemTests'
					with: [ spec requires: #('ExercismTests') ];
				package: 'ExercismWIP'
					with: [ spec requires: #('ExercismTools') ];
				package: 'ExercismDev'
					with: [ spec
						requires:
							#('ExercismTools' 'OSSubprocess' 'OSWinSubprocess')
								, self class exercisePackageNames	"For shelling out to configlet" ];
				package: 'ExercismTestRunner'
					with:
						[ spec requires: #('ExercismTools') , self class exercisePackageNames ];
				package: 'ExercismTestRunnerTests'
					with: [ spec requires: #('ExercismTestRunner' 'ExercismTests') ];
				package: 'ExercismV3';
				group: 'default' with: #('ExercismTools' 'Exercise@Welcome');
				group: 'mentor' with: #('ExercismDev');
				group: 'dev'
					with: #('ExercismDev' 'ExercismWIP' 'ExercismSystemTests');
				group: 'testRunner' with: #('ExercismTestRunner');
				group: 'testRunnerTests' with: #('ExercismTestRunnerTests'), self class exerciseGoldenTestPackageNames;
				group: 'v3' with: #('ExercismV3')
			].
			spec for: #'pharo11.x' do: [
				"ExercismTools methods will add methods from compatibility package for Pharo 11"
				spec package: 'ExercismTools' with: [ spec includes: #('ExercismPharo110') ].
				spec package: 'ExercismPharo110'
			].
			spec for: #'pharo12.x' do: [
				"ExercismTools methods will be overwritten by compatibility package for Pharo 12"
				spec package: 'ExercismTests' with: [ spec includes: #('ExercismPharo120') ].
				spec package: 'ExercismPharo120' with: [ spec requires: #('ExercismTests') ]
			]
]

{ #category : 'baselines' }
BaselineOfExercism >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : 'baselines' }
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

{ #category : 'baselines' }
BaselineOfExercism >> setUpDependencies: spec [

	spec 
		baseline: 'OSSubprocess'
 		with: [spec repository: 'github://pharo-contributions/OSSubprocess:master/repository'].
	
	spec 
		baseline: 'OSWinSubprocess'
 		with: [spec repository: 'github://pharo-contributions/OSWinSubprocess:master/repository'].
					
	spec
    	baseline: 'Mocketry'
    	with: [ spec repository: 'github://dionisiydk/Mocketry:v7.0.x' ].
	
	spec
    	baseline: 'Ring2'
    	with: [ spec repository: 'github://pavel-krivanek/Ring2'; loads: #(calypso)].
]

{ #category : 'baselines' }
BaselineOfExercism >> setUpExercisesFor: spec [
	self class exercisePackageNames, self class exerciseTestPackageNames 
		do:
			[ :name | spec package: name with: [ spec requires: #('ExercismTools') ] ]
]

{ #category : 'baselines' }
BaselineOfExercism >> setUpGoldenTestsFor: spec [
	
	self class exerciseGoldenTestPackageNames 
		do:
			[ :name | spec package: name with: [ spec requires: #('ExercismTools') ] ]
]
