"
# ExercismGenerator

I am an abstract class responsible for generating kebab-cased Exercism directories, each containing a seperate 
exercise for users. My subclasses implement exercise generation for the different versions of Exercism.

Exercism requires plain text files that can be served to the website as exercises and then downloaded for a student 
to work on. We have to do it this way as Exercism conventions differ from Tonel, and so we need to output them to a 
seperate directory suitable for the Exercism command line tool.

## Collaborators

I work with `ExTonelWriter` which does the actual job of writing Tonel format files to disk.

## Usage

When you have created a new exercise(s) that you are happy with, you need to run a generation. This
will need to be done with one of my subclasses depending on which version you want to generate for:
`ExercismV2Generator` for version 2 and `ExercismV3Generator` for version 3.

You can run the `#generate` class method with one of my subclasses and be prompted for a file location 
(where the path is one that points to where you have checked out the entire pharo project using either 
the command line or a git tool):

```
ExercismV2Generator generate
```

In any other context I will need to have `exercisesPath` and `exTonelWriter` instance variables initialized
before `#generate` is sent to me.

```
ExercismV2Generator new
	exercisesPath: (FileSystem memory root / 'exercises');
	exTonelWriter: (ExTonelWriter on: path);
	generate
```

## Instance Variables

- exercisesPath: The file path exercises are written to. Defaults to the class variable `DefaultPath`.
- exTonelWriter: `ExTonelWriter`; Responsible for writing objects as Tonel format source text files to the give file path.

## Class Variables

- DefaultPath: The default file path that Tonel files will be written to.
"
Class {
	#name : #ExercismGenerator,
	#superclass : #Object,
	#instVars : [
		'exercisesPath',
		'exTonelWriter'
	],
	#classVars : [
		'DefaultPath'
	],
	#category : #'ExercismDev-Generator'
}

{ #category : #helper }
ExercismGenerator class >> defaultPath [
	^ DefaultPath ifNil: [ self defaultPath: FileLocator home pathString]
]

{ #category : #helper }
ExercismGenerator class >> defaultPath: pathString [
	^ DefaultPath := pathString
]

{ #category : #generation }
ExercismGenerator class >> generate [

	self subclassResponsibility 
]

{ #category : #accessing }
ExercismGenerator >> exTonelWriter: anExTonelWriter [ 

	exTonelWriter := anExTonelWriter
]

{ #category : #accessing }
ExercismGenerator >> exercisesPath: aFileReference [
 
	exercisesPath := aFileReference
]
