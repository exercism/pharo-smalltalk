Extension { #name : #SugsGlamourCodeContext }

{ #category : #'*ExercismTools' }
SugsGlamourCodeContext >> contentSelection [
	^selectedNode source copyFrom: selectedNode start to: selectedNode stop 
]

{ #category : #'*ExercismTools' }
SugsGlamourCodeContext >> selectionInterval [
	^selectedNode start to: selectedNode stop
]
