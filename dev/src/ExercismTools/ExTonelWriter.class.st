"
I am a TonelWriter that provides finer level control of writing Tonel files for Exercism
"
Class {
	#name : #ExTonelWriter,
	#superclass : #TonelWriter,
	#instVars : [
		'sourceDirectory'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #'*ExercismTools' }
ExTonelWriter >> mappedSnapshot: aSnapshot [
	"extracted from #writeSnapshot: to customise behavior"
	
	|tonelMap|
	snapshot := aSnapshot.
	tonelMap := Dictionary new.
	
	"ignore packages (as done in #writeSnapshot:"
	
	"now export classes - but to a map"
	(snapshot definitions select: #isClassDefinition)
		do: [ :classdef |  |tonelStream|
			tonelStream := WriteStream on: String new.
	 		self writeClass: classdef on: tonelStream.
	  		tonelMap at: classdef className put: tonelStream contents ].
	
	"... and method extensions"
	"tbd - self writeMethodExtensions"
	
	^tonelMap

]

{ #category : #private }
ExTonelWriter >> obtainPackageDir: aDefinition [
	"Overridden to allow a specific directory to be supplied"
	
	^self sourceDirectory ifNil: [ super obtainPackageDir: aDefinition ]
]

{ #category : #accessing }
ExTonelWriter >> sourceDirectory [
	^ sourceDirectory
]

{ #category : #accessing }
ExTonelWriter >> sourceDirectory: anObject [
	sourceDirectory := anObject
]

{ #category : #'*ExercismTools' }
ExTonelWriter >> writeClass: aClassDefinition on: aStream [
	"Not clear on whether this is an override and still needed? ~tma~"
	
	self writeClassDefinition: aClassDefinition on: aStream.
	self writeClassSideMethodDefinitions: aClassDefinition on: aStream.
	self writeInstanceSideMethodDefinitions: aClassDefinition on: aStream 
]
