"
I represent an external process for use in testing. To avoid hard to test behaviour
and side effects in classes that use me some of my superclasses methods have been 
overriden.  

## Overridden Methods

### `#runAndWait`

Normally I would execute an external command here. Instead I make no external
process calls or side effects and return `self`.

### `#isSuccess`

Answers `true`. I always assume my external command has succeeded.

"
Class {
	#name : #SuccessfulTestOSProcess,
	#superclass : #MockTestOSProcess,
	#category : #'ExercismTests-Mock'
}

{ #category : #testing }
SuccessfulTestOSProcess >> isSuccess [

	^ true
]
