Extension { #name : #WorldMorph }

{ #category : #'*ExercismTools' }
WorldMorph >> openModal: aSystemWindow [

	|modalMorph|
	modalMorph := self submorphs detect: #isSystemWindow ifNone: [ self error: 'Could not find a system window to open a modal dialog.' ].

	^ modalMorph openModal: aSystemWindow

]
