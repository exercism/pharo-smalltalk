"
I represent code export functionality for given Exercism exercise. Output is in Tonel format (version specific) which is represented as dictionary, where file names are keys, and source code in Tonel format is represented as values in disctionary.
"
Class {
	#name : 'ExercismCodeExporter',
	#superclass : 'Object',
	#instVars : [
		'tonelWriter'
	],
	#category : 'ExercismTools-Core',
	#package : 'ExercismTools',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExercismCodeExporter class >> on: directoryReference [
	
	^ self basicNew
		initializeWith: directoryReference;
		yourself
]

{ #category : 'private' }
ExercismCodeExporter >> addClassDefinitionsIn: tonelMap using: collectionOfDefinitions [

	collectionOfDefinitions do: [ :classDef |  
		| filename tonelStream |
		filename := classDef exTonelFilename.
		tonelStream := WriteStream on: String new.
	 	self writeClass: classDef on: tonelStream.
	  	tonelMap at: filename put: tonelStream 
	].

]

{ #category : 'private' }
ExercismCodeExporter >> addExtensionDefinitionsIn: tonelMap using: collectionOfDefinitions [

	collectionOfDefinitions do: [ :methodDef | 
		|filename|
		filename := methodDef exTonelFilename.
		tonelMap at: filename ifAbsentPut: [ 
			(WriteStream on: String new) 
				nextPutAll: 'Extension { #name : #';
				nextPutAll: methodDef className;
				nextPutAll: ' }';
				lf; 
				yourself
		].
		tonelWriter writeMethodDefinition: methodDef on: (tonelMap at: filename). 
	]
]

{ #category : 'initialize' }
ExercismCodeExporter >> directoryReference: directoryReference [
	
 	tonelWriter directoryReference: directoryReference
]

{ #category : 'initialize' }
ExercismCodeExporter >> initialize [

	super initialize.
	tonelWriter := TonelWriter new.
]

{ #category : 'initialize' }
ExercismCodeExporter >> initializeWith: directoryReference [
	
	self initialize.
 	self directoryReference: directoryReference
]

{ #category : 'API - actions' }
ExercismCodeExporter >> mappedSnapshot: aSnapshot [
	"extracted from #writeSnapshot: to customise behavior"
	
	| tonelMap |
	"this is needed since methods below that use tonel writer uses snapshot inst. variable"
	tonelWriter snapshot: aSnapshot.
	tonelMap := Dictionary new.
		
	"Tonel export classes with their methods, mapped from their filename to content streams"
	self addClassDefinitionsIn: tonelMap using: aSnapshot classDefinitions.
	
	"... and method extensions"
	self addExtensionDefinitionsIn: tonelMap using: aSnapshot extensionDefinitions.
	^tonelMap

]

{ #category : 'private' }
ExercismCodeExporter >> writeClass: aClassDefinition on: aStream [
	"Not clear on whether this is an override and still needed? ~tma~"
	
	tonelWriter writeClassDefinition: aClassDefinition on: aStream.
	tonelWriter writeClassSideMethodDefinitions: aClassDefinition on: aStream.
	tonelWriter writeInstanceSideMethodDefinitions: aClassDefinition on: aStream 
]

{ #category : 'API - actions' }
ExercismCodeExporter >> writeSnapshot: aSnapshot [

	tonelWriter writeSnapshot: aSnapshot
]
