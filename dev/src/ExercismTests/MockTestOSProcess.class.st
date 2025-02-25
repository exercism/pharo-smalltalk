"
I represent an external process for use in testing. I by-pass methods that are used in OSSubProcess or OSWinSubProcess libraries.
"
Class {
	#name : 'MockTestOSProcess',
	#superclass : 'Object',
	#category : 'ExercismTests-Mock',
	#package : 'ExercismTests',
	#tag : 'Mock'
}

{ #category : 'mocking' }
MockTestOSProcess >> arguments: argList [
"do nothing"
]

{ #category : 'mocking' }
MockTestOSProcess >> command: aCmdString [
"do nothing"
]

{ #category : 'mocking' }
MockTestOSProcess >> isSuccess [

	self subclassResponsibility
]

{ #category : 'mocking' }
MockTestOSProcess >> lastError [ 

	^ 'Mock error happened.'
]

{ #category : 'mocking' }
MockTestOSProcess >> redirectStdout [
"do nothing"
]

{ #category : 'mocking' }
MockTestOSProcess >> runAndWait [ 
	"do nothing"
	^ self 
]

{ #category : 'mocking' }
MockTestOSProcess >> workingDirectory: pathString [
	"do nothing"
]
