"
An ExercismTonelReaderTest is a test class for testing the behavior of ExercismTonelReader
"
Class {
	#name : 'ExercismTonelReaderTest',
	#superclass : 'TestCase',
	#category : 'ExercismTests-UnitTests',
	#package : 'ExercismTests',
	#tag : 'UnitTests'
}

{ #category : 'private' }
ExercismTonelReaderTest >> getSourceFileWithCommentsOnly [

	|srcFileWithCommentsOnly |
	srcFileWithCommentsOnly := (FileSystem memory root / 'MyClass.st') ensureCreateFile.
	srcFileWithCommentsOnly writeStreamDo: [:str |
		str 
			cr; cr;
	 		nextPutAll: '"some comments"';
			cr;
		 	nextPutAll: '"some more comments"'
	].
	^ srcFileWithCommentsOnly
]

{ #category : 'private' }
ExercismTonelReaderTest >> getSourceFileWithDefinitions [

	|srcFileWithCommentsOnly |
	srcFileWithCommentsOnly := (FileSystem memory root / 'MyClass.st') ensureCreateFile.
	srcFileWithCommentsOnly writeStreamDo: [:str |
		str << '"some comments"';
			cr; cr;
		 	<< 'Class {'; cr;
			<< '#name : ''MyClass'','; cr;
			<< '#superclass : ''Object'','; cr;
			<< '#instVars : [ ],'; cr;
 			<< '#classVars : [ ],'; cr;
			<< '#category : ''MyClassPackage'','; cr;  
			<< '#package : ''MyClassPackage '''; cr;
			<< '}'; cr; cr
	].
	^ srcFileWithCommentsOnly
]

{ #category : 'tests' }
ExercismTonelReaderTest >> testCanBeLoaded [

	|reader|
	reader := ExercismTonelReader new.
	self deny: (reader canBeLoaded: self getSourceFileWithCommentsOnly).
	self assert: (reader canBeLoaded: self getSourceFileWithDefinitions).
]

{ #category : 'tests' }
ExercismTonelReaderTest >> testContainsCommentsOnly [

	|reader|
	reader := ExercismTonelReader new.
	self assert: (reader containsCommentsOnly: self getSourceFileWithCommentsOnly).
	self deny: (reader containsCommentsOnly: self getSourceFileWithDefinitions).
]
