Extension { #name : #TonelReader }

{ #category : #'*ExercismTools' }
TonelReader >> exerciseDirectory: aDirReference [

	packageDirectory := aDirReference
]

{ #category : #'*ExercismTools' }
TonelReader class >> fromExerciseDirectory: aDirectory [

	"set exercise directory where all source files of exercise occur"

	^ self new
		exerciseDirectory: aDirectory;
		yourself 
]
