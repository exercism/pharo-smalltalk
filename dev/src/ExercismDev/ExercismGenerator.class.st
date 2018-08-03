"
I am responsible for generating kebab-cased Exercism edirectories, each containing a seperate exercise for users.

We have to do it this way as Exercism conventions differ from Tonel, and so we need to output them to a seperate directory suitable for  the Exercism command line tool.

When you have created a new exercise(s) that you are happy with, you need to run a generation.

You can either click on the #generate example method and be prompted for a file location or evaluate the following  (where the path is one that points to where you have checked out the entire pharo project using either the command line or a git tool):

ExercismGenerator generateTo: (FileLocator home / 'Dev/Exercism/pharo-git') pathString
"
Class {
	#name : #ExercismGenerator,
	#superclass : #Object,
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
	"self generate"

	<example>
	| path |
	path := UIManager default
		chooseDirectory: 'Select the location of Exercism git project'
		path: self defaultPath.
	path ifNotNil: [ self generateTo: (self defaultPath: path) ].
	path
]

{ #category : #helper }
ExercismGenerator class >> generateSourceFilesFor: packageOrTag to: filePathString [
	| writer exerciseDirectory destinationDirectory |
	
	"Note: could create the writer on a memory stream to then pick what should be stored on disk
	e.g.
		mem := FileSystem memory root.
		writer := ExTonelWriter on: mem."
		
	writer := ExTonelWriter new.
	writer
		packageDir: (exerciseDirectory := self kebabCase: packageOrTag name);
		sourceDir: filePathString asFileReference;
		writeSnapshot: (self tagSnapshotFor: packageOrTag).

	destinationDirectory := filePathString asFileReference	/ exerciseDirectory.

	self generatedReadmeFor: packageOrTag to: destinationDirectory.
	
	"Remove the extra package file as its not needed for Exercism"
	(destinationDirectory / 'package.st') delete.
	
]

{ #category : #generation }
ExercismGenerator class >> generateTo: filePathString [
	(RPackage organizer packageNamed: 'Exercism') packages do: [:pkg |
			self generateSourceFilesFor: pkg to: filePathString ]
]

{ #category : #helper }
ExercismGenerator class >> generatedReadmeFor: packageOrTag to: destinationDirectory [
	packageOrTag classes
		detect: [ :c | c isTestCase ]
		ifFound:
			[ :c | (destinationDirectory / 'README.md') writeStream nextPutAll: c comment ]
]

{ #category : #helper }
ExercismGenerator class >> kebabCase: aString [
	"Answer a String that converts the CamelCase input to camel-case kebab output"

	^ String
		streamContents: [ :kebabStream | 
			aString uncapitalized
				do: [ :char | 
					char isUppercase
						ifTrue: [ kebabStream nextPut: $- ].
					kebabStream nextPut: char asLowercase ] ]
]

{ #category : #helper }
ExercismGenerator class >> tagSnapshotFor: packageOrTag [
	| parentSnapshot tagSnapshot |
	parentSnapshot := (MCPackage named: packageOrTag package name)
		snapshot.
	tagSnapshot := MCSnapshot
		fromDefinitions:
			(parentSnapshot definitions
				select: [ :mc | 
					mc className isNil
						or: [ mc actualClass category endsWith: packageOrTag name ] ]).
	^ tagSnapshot
]
