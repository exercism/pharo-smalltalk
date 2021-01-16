Class {
	#name : #MockExercismV3Exercise,
	#superclass : #ExercismExercise,
	#category : #'ExercismTools-Meta'
}

{ #category : #'instance creation' }
MockExercismV3Exercise class >> allExercises [ 

	^ { RemoteControlCarTest exercise } asOrderedCollection 
]
