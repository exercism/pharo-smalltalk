Extension { #name : #ExTonelWriter }

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

{ #category : #'*ExercismTools' }
ExTonelWriter >> writeClass: aClassDefinition on: aStream [
	"Not clear on whether this is an override and still needed? ~tma~"
	
	self writeClassDefinition: aClassDefinition on: aStream.
	self writeClassSideMethodDefinitions: aClassDefinition on: aStream.
	self writeInstanceSideMethodDefinitions: aClassDefinition on: aStream 
]
