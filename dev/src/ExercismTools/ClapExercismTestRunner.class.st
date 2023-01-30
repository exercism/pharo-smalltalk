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
			implicitMeaning: [ :arg :app | self error: 'Missing slug name argument.' ]);
		add: ((ClapPositional id: #input)
			description: 'Input directory, where solution with source code is located.';
			meaning: [ :pos | pos word asSymbol ];
			implicitMeaning: [ :arg :app | self error: 'Missing input directory argument.' ]);
		add: ((ClapPositional id: #output)
			description: 'Output directory, where results.json is located.';
			meaning: [ :pos | pos word asSymbol ];
			implicitMeaning: [ :arg :app | self error: 'Missing output directory parameter.' ]);
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

	self outStream nextPutAll: 'Executed.'; lf
]

{ #category : #execution }
ClapExercismTestRunner >> inputDir [
	^ (arguments at: #input) value: self
]

{ #category : #accessing }
ClapExercismTestRunner >> outStream [
	^ outStream ifNil: [ outStream := VTermOutputDriver on: arguments context stdout ]
]

{ #category : #execution }
ClapExercismTestRunner >> outputDir [
	^ (arguments at: #output) value: self
]

{ #category : #execution }
ClapExercismTestRunner >> slugName [
^ (arguments at: #slug) value: self
]
