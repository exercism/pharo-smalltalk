"
# ExercismV3Generator

I am responsible for generating kebab-cased Exercism V3 directories, each containing a seperate exercise for users.
Use me to create exercises for Exercism version 3.

## Collaborators

`PipeableOSProcess` is needed to make a external command line call to the configlet tool. The 
configlet tool will need to be installed on the host operating system.

To grab the exercises that need to be written I use `ExercismExercise`.

## Instance Variables

- exercismExercise: A class handle for easily getting all the implemented exercises. Defaults to `ExercismExercise`.
- osProcess: A class handle of an operating system process, for sending external commands.
"
Class {
	#name : #ExercismV3Generator,
	#superclass : #ExercismGenerator,
	#instVars : [
		'osProcess',
		'exercismExercise'
	],
	#category : #'ExercismDev-Generator'
}

{ #category : #generation }
ExercismV3Generator class >> generate [
	"This is the entry point for generating exercism compatible source files that can be checked into
	the exercism/pharo project. e.g. self generate"

	<example>
	| path |
	path := UIManager default
		chooseDirectory: 'Select the /exercises location in a fresh Exercism/Pharo git project'
		path: self defaultPath.
		
	path ifNotNil: [
		self new 
			exercisesPath: path;
			exTonelWriter: (ExTonelWriter on: path);
			generate
			]
]
