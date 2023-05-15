"
I am a TonelWriter that provides finer level control of writing Tonel files for Exercism
"
Class {
	#name : #ExTonelWriter,
	#superclass : #TonelWriterV1,
	#instVars : [
		'sourceDirectory'
	],
	#category : #ExercismPharo110
}

{ #category : #private }
ExTonelWriter >> obtainPackageDir: aDefinition [
	"Overridden to allow a specific directory to be supplied"
	
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
