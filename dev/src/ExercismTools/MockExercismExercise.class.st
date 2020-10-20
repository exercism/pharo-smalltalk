"
# MockExercismExercise

I am a subclass of `ExercismExercise` exclusively for use in testing. I override `#allExercises`
to return a small number of exercises instead of all the exercises in production,
which can grow in number. This is to help keep tests fast and predictable.

## Overridden Methods

### `#allExercises`

Answers a small constant number of exercises.
"
Class {
	#name : #MockExercismExercise,
	#superclass : #ExercismExercise,
	#category : #'ExercismTools-Meta'
}

{ #category : #'instance creation' }
MockExercismExercise class >> allExercises [ 

	^ { TwoFerTest exercise } asOrderedCollection 
]
