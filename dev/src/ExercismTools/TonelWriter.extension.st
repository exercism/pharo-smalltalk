Extension { #name : #TonelWriter }

{ #category : #'*ExercismTools' }
TonelWriter >> mappedSnapshot: aSnapshot [
	"extracted from #writeSnapshot:"
	|tonelMap|
	snapshot := aSnapshot.
	tonelMap := Dictionary new.
	(snapshot definitions select: #isClassDefinition)
		do: [ :classdef |  |tonelStream|
			tonelStream := WriteStream on: String new.
	 		self writeClass: classdef on: tonelStream.
	  		tonelMap at: classdef className put: tonelStream contents ].
	^tonelMap

]

{ #category : #'*ExercismTools' }
TonelWriter >> writeClass: aClassDefinition on: aStream [
	self writeClassDefinition: aClassDefinition on: aStream.
	self writeClassSideMethodDefinitions: aClassDefinition on: aStream.
	self writeInstanceSideMethodDefinitions: aClassDefinition on: aStream 
]
