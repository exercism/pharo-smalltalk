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

{ #category : #private }
ExTonelWriter >> obtainPackageDir: aDefinition [
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
