"
I represent Binary Search Tree. I can insert data and have references to left and right subtrees that are of same kind as me. I support operations like: data, left and right. I have sortedData operation to return sorted data elements.
"
Class {
	#name : 'BinarySearchTree',
	#superclass : 'Object',
	#instVars : [
		'data',
		'left',
		'right'
	],
	#category : 'Exercise@BinarySearchTree',
	#package : 'Exercise@BinarySearchTree'
}

{ #category : 'adding' }
BinarySearchTree >> addNode: aString [ 
	
	self data ifNil: [^ self data: aString].
	aString <= self data 
		ifTrue: [ self getOrCreateLeftNode addNode: aString ]
		ifFalse: [ self getOrCreateRightNode addNode: aString ]
]

{ #category : 'accessing' }
BinarySearchTree >> data [

	^ data
]

{ #category : 'private' }
BinarySearchTree >> data: anObject [

	data := anObject
]

{ #category : 'private' }
BinarySearchTree >> getOrCreateLeftNode [ 
	
	^ self left ifNil: [ self left: self class new. self left ]
]

{ #category : 'private' }
BinarySearchTree >> getOrCreateRightNode [ 
	
	^ self right ifNil: [ self right: self class new. self right ]
]

{ #category : 'accessing' }
BinarySearchTree >> left [

	^ left
]

{ #category : 'private' }
BinarySearchTree >> left: anObject [

	left := anObject
]

{ #category : 'exercism' }
BinarySearchTree >> leftMostOrderOn: resultCollection [

	self left ifNotNil: [ self left leftMostOrderOn: resultCollection ].
	resultCollection add: self data.
	self right ifNotNil: [ self right leftMostOrderOn: resultCollection  ].
]

{ #category : 'accessing' }
BinarySearchTree >> right [

	^ right
]

{ #category : 'private' }
BinarySearchTree >> right: anObject [

	right := anObject
]

{ #category : 'exercism' }
BinarySearchTree >> sortedData [

	|resultCollection|
	resultCollection := OrderedCollection new.
	self leftMostOrderOn: resultCollection.
	^ resultCollection asArray 
]

{ #category : 'input' }
BinarySearchTree >> treeData: aCollection [ 
	
	aCollection do: [:element | self addNode: element]
]
