"
I am an authorisation error for Exercism
"
Class {
	#name : 'ExUnauthorized',
	#superclass : 'ExercismError',
	#instVars : [
		'token'
	],
	#category : 'ExercismTools-Core',
	#package : 'ExercismTools',
	#tag : 'Core'
}

{ #category : 'instance-creation' }
ExUnauthorized class >> signalBadToken: tokenStringOrNil [
	^ self new
		token: tokenStringOrNil;
		signal
]

{ #category : 'accessing' }
ExUnauthorized >> token [
	^ token
]

{ #category : 'accessing' }
ExUnauthorized >> token: anObject [
	token := anObject
]
