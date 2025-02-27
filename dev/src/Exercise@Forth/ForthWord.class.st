"
I represent an entry in the Forth vocabulary

Public API
 - execute
"
Class {
	#name : 'ForthWord',
	#superclass : 'Object',
	#instVars : [
		'name',
		'definition'
	],
	#category : 'Exercise@Forth',
	#package : 'Exercise@Forth'
}

{ #category : 'accessing' }
ForthWord >> definition [
	^ definition
]

{ #category : 'accessing' }
ForthWord >> definition: anObject [
	definition := anObject
]

{ #category : 'execution' }
ForthWord >> execute [
	definition isBlock
		ifTrue: [ definition value ]
		ifFalse: [ definition do: [ :each | each execute ] ]
]

{ #category : 'accessing' }
ForthWord >> name [
	^ name
]

{ #category : 'accessing' }
ForthWord >> name: anObject [
	name := anObject
]
