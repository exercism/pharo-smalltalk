"
I represent circular buffer - a data structure that uses a single, fixed-size buffer as if it were connected end-to-end. I support operations like read, write, overwrite, clear.
"
Class {
	#name : #CircularBuffer,
	#superclass : #Object,
	#instVars : [
		'buffer',
		'capacity'
	],
	#category : #'Exercise@CircularBuffer'
}

{ #category : #private }
CircularBuffer >> buffer [

	^ buffer
]

{ #category : #private }
CircularBuffer >> buffer: anObject [

	buffer := anObject
]

{ #category : #private }
CircularBuffer >> bufferFull [

	^ self buffer size >= self capacity
]

{ #category : #accessing }
CircularBuffer >> capacity [

	^ capacity
]

{ #category : #accessing }
CircularBuffer >> capacity: anObject [

	capacity := anObject
]

{ #category : #operations }
CircularBuffer >> clear [

	self buffer removeAll
]

{ #category : #initialization }
CircularBuffer >> initialize [ 

	super initialize.
	self buffer: OrderedCollection new
]

{ #category : #operations }
CircularBuffer >> overwrite: aValue [

	self bufferFull ifTrue: [ self buffer removeFirst ].
	^ self write: aValue
]

{ #category : #'error signalling' }
CircularBuffer >> raiseEmptyBufferOnRead [

	^ Error signal: 'Cannot read from empty buffer!'
]

{ #category : #'error signalling' }
CircularBuffer >> raiseFullBufferOnWrite [

	^ Error signal: 'Cannot write to full buffer!'
]

{ #category : #operations }
CircularBuffer >> read [

	self buffer ifEmpty: [ ^ self raiseEmptyBufferOnRead ].
	^ self buffer removeFirst
	
]

{ #category : #operations }
CircularBuffer >> write: aValue [
	
	self bufferFull ifTrue: [ ^ self raiseFullBufferOnWrite ].
	^ self buffer addLast: aValue.
]
