"
I am a TonelWriter that provides finer level control of writing Tonel files for Exercism
"
Class {
	#name : #ExTonelWriter,
	#superclass : #TonelWriter,
	#category : #'ExercismTools-Core'
}

{ #category : #writing }
ExTonelWriter >> packageDir: aString [
	packageDir := aString 
]

{ #category : #writing }
ExTonelWriter >> writePackage: aDefinition [
	"Overriden to allow a packageDir to be specified"
	
	self packageDir ifNil: [ self packageDir: aDefinition categories first ].
	self flag: #todo. "this is lame... removing and rewriting full package needs to be rethink :)"
	(self fileUtils directoryExists: self packageDir) ifTrue: [ 
		self fileUtils deleteAll: self packageDir ].  
	self fileUtils ensureDirectoryExists: self packageDir.
	self fileUtils 
		writeStreamFor: 'package.st' 
		in: self packageDir 
		do: [ :s | 
			s 
				<< 'Package ' 
				<< (self toSTON: { #name ->  packageDir asSymbol } asDictionary) 
				<< self newLine ]
]
