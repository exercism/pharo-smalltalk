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
	#category : #'ExercismDev-Generator'
}

{ #category : #generation }
ExercismGenerator class >> generate [
	<example>
	| path |
	path := UIManager default chooseDirectory: 'Select the location of Exercism git project' path: (FileLocator home ) pathString.
	
	path ifNotNil: [ self generateTo: path ].
	path

]

{ #category : #helper }
ExercismGenerator class >> generateFilesFor: packageOrTag to: filePathString [ 
	| writer exerciseDirectory |
	
	"Note: could create the writer on a memory stream to then pick what should be stored on disk
	e.g.
		mem := FileSystem memory root.
		writer := ExTonelWriter on: mem."
	
	writer := ExTonelWriter new.
	writer packageDir: (exerciseDirectory := self kebabCase: packageOrTag name).
	writer
		sourceDir: filePathString asFileReference;
		writeSnapshot: (MCPackage named: packageOrTag package name) snapshot.
		
	"Remove the extra package file as its not needed for Exercism"
	(filePathString asFileReference / exerciseDirectory / 'package.st')  delete.
	
	packageOrTag classes detect: [ :c | c isTestCase ] ifFound: [  :c |
		 (filePathString asFileReference / exerciseDirectory / 'README.md') writeStream
				nextPutAll: c comment]
]

{ #category : #generation }
ExercismGenerator class >> generateTo: filePathString [
	(RPackageOrganizer default packageNamed: 'Exercism') packages do: [:pkg |
			self generateFilesFor: pkg to: filePathString ]
]

{ #category : #helper }
ExercismGenerator class >> kebabCase: aString [
	"Answer a String that converts the CamelCase input to camel-case kebab output"

	| kebabSring inputString |
	
	inputString := aString uncapitalized.
	kebabSring := String streamContents: [ :kebabStream | 
			| wordStream |
			wordStream := (String new: 16) writeStream.
			inputString 	do: [ :char | 
					char isUppercase
						ifTrue: [ 
							kebabStream
								nextPutAll: wordStream contents;
								nextPut: $-.
							wordStream reset ].
					wordStream nextPut: char asLowercase].
			wordStream position > 0
				ifTrue: [ kebabStream nextPutAll: wordStream contents ] ].
	^ kebabSring
]
