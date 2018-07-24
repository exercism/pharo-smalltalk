Class {
	#name : #ExTonelWriter,
	#superclass : #TonelWriter,
	#category : #XercismTools
}

{ #category : #writing }
ExTonelWriter >> packageDir: aString [
	packageDir := aString 
]

{ #category : #writing }
ExTonelWriter >> writePackage: aDefinition [
	"I'm assuming first category is actually the package"
	
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
