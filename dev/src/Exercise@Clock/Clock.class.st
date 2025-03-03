"
I am a simple Clock object
"
Class {
	#name : 'Clock',
	#superclass : 'Object',
	#instVars : [
		'hour',
		'minute'
	],
	#category : 'Exercise@Clock',
	#package : 'Exercise@Clock'
}

{ #category : 'exercism' }
Clock class >> hour: hourInteger minute: minuteInteger [ 
	^self new 
		initializeHour: hourInteger minute: minuteInteger;
		yourself
]

{ #category : 'arithmetic' }
Clock >> + anInteger [
	"Answer a new instance of the receiver added to anInteger minutes"
	
	^ self class hour: self hour minute: self minute + anInteger
]

{ #category : 'arithmetic' }
Clock >> - anInteger [
	"Answer a new instance of the receiver subtracted by anInteger minutes"

	^ self class hour: self hour minute: self minute - anInteger
]

{ #category : 'comparing' }
Clock >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ minute = anObject minute and: [ hour = anObject hour ]
]

{ #category : 'comparing' }
Clock >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ minute hash bitXor: hour hash
]

{ #category : 'accessing' }
Clock >> hour [
	^ hour
]

{ #category : 'initializing' }
Clock >> initializeHour: hourInteger minute: minuteInteger [

	hour := (minuteInteger // 60 + hourInteger) % 24.
	minute := minuteInteger % 60
]

{ #category : 'accessing' }
Clock >> minute [
	^ minute
]

{ #category : 'printing' }
Clock >> printOn: aStream [
	"Output the reciever on a Stream for printing, debugging etc."

	aStream nextPutAll: ('{1}{2}:{3}{4}' format: {
		(hour < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		hour.
		(minute < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		minute })
]
