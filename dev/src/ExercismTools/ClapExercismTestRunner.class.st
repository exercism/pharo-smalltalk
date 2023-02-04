"
I represent commamand line interface of Exercism test runner interface. I can be invoked from command line e.g. by using `<path-to-pharo-vm>/pharo --headless <path-to-pharo-image>pharo.image clap testExercise <slug-name> <input-directory> <output-directory>`
- I parse command line arguments and execute appropriate command to run Exercism test runner functionality with desired arguments.
- I inform about execution on command line standard output stream (stdout) or error stream (stderr).
"
Class {
	#name : #ClapExercismTestRunner,
	#superclass : #ClapApplication,
	#instVars : [
		'outStream',
		'errStream'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #'command line' }
ClapExercismTestRunner class >> testRunnerCommand [
	<commandline>
	^ (ClapCommand id: #testExercise)
		description: 'Runs Exercism test runner for given exercise.';
		add: ClapFlag forHelp;
		add: ((ClapPositional id: #slug)
			description: 'Slug name of given exercise (e.g. "hello-world").';
			meaning: [ :pos | pos word asSymbol ];
			implicitMeaning: [ :arg :app | ExDomainError signal: 'Missing slug name argument.' ]);
		add: ((ClapPositional id: #input)
			description: 'Input directory, where solution with source code is located.';
			meaning: [ :pos | pos word asSymbol ];
			implicitMeaning: [ :arg :app | ExDomainError signal: 'Missing input directory argument.' ]);
		add: ((ClapPositional id: #output)
			description: 'Output directory, where results.json is located.';
			meaning: [ :pos | pos word asSymbol ];
			implicitMeaning: [ :arg :app | ExDomainError signal: 'Missing output directory parameter.' ]);
		meaning: [ :args |
			args at: #helpFlag ifPresent: [ :help |
				help value; exitSuccess ].
			args validateAll.
			
			(self with: args) execute 
		];
		yourself
]

{ #category : #accessing }
ClapExercismTestRunner >> errStream [
	^ errStream ifNil: [ errStream := VTermOutputDriver on: arguments context stderr]
]

{ #category : #execution }
ClapExercismTestRunner >> execute [

	[ 
		|testResult|
		"print CLI args"
		self printInpuCmdLineArguments.

		"executing test runner with CLI arguments"
		testResult := ExercismTestRunner  default 
			runTestsOnExercise: self slugName 
			importSourceFrom: self inputDir asFileReference 
			result: self outputDir asFileReference.
		"print result"
		self outStream nextPutAll: testResult asString;
		nextPutAll: OSPlatform current lineEnding.
	]	on: Error
		do: 
		[ :exception | 
			self errStream	
				nextPutAll: ('Error: {1}' format: {  exception messageText}); 
				nextPutAll: OSPlatform current lineEnding.
			^ Smalltalk exitFailure
		]
]

{ #category : #accessing }
ClapExercismTestRunner >> inputDir [
	^ (arguments at: #input) value: self
]

{ #category : #accessing }
ClapExercismTestRunner >> outStream [
	^ outStream ifNil: [ outStream := VTermOutputDriver on: arguments context stdout ]
]

{ #category : #accessing }
ClapExercismTestRunner >> outputDir [
	^ (arguments at: #output) value: self
]

{ #category : #private }
ClapExercismTestRunner >> printInpuCmdLineArguments [

	self outStream 
		nextPutAll: ('Loading sources for exercise: ''{1}'' from input directory: ''{2}'', result to output directory: ''{3}''.' format: {self slugName. self inputDir. self outputDir.});
		nextPutAll: 	OSPlatform current lineEnding 
]

{ #category : #accessing }
ClapExercismTestRunner >> slugName [
^ (arguments at: #slug) value: self
]
