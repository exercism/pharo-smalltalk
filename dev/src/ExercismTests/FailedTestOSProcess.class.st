"
# FailedTestOSProcess

I represent an external process for use in testing. To avoid hard to test behaviour
and side effects in classes that use me some of my superclasses methods have been 
overriden.

## Overridden Methods

### `#waitForCommand:`

Normally I would execute an external command here. Instead I make no external
process calls or side effects and return `self`.

### `#succeeded`

Answers `false`. I always assume my external command has failed.
"
Class {
	#name : #FailedTestOSProcess,
	#superclass : #PipeableOSProcess,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #testing }
FailedTestOSProcess >> succeeded [ 

	^ false
]

{ #category : #'external command processing' }
FailedTestOSProcess >> waitForCommand: aCommandString [ 
	
	^ self
]
