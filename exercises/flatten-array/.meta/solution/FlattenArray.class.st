"
Mentor notes:

- using isCollection simplifies this a lot
- can be rescursive or not
"
Class {
	#name : #FlattenArray,
	#superclass : #Object,
	#category : #'Exercise@FlattenArray'
}

{ #category : #helper }
FlattenArray >> flatten: anObject onto: result [
	anObject isCollection
		ifTrue: [ anObject do: [ :item | self flatten: item onto: result ] ]
		ifFalse: [ anObject ifNotNil: [ result nextPut: anObject ] ]
]

{ #category : #exercism }
FlattenArray >> flattenArray: aCollection [ 
	
	^(OrderedCollection streamContents: [ :s |
		self flatten: aCollection onto: s ]) asArray 
	
]
