"
Mentor notes:

- this alternate solution demonstrates how creating a new stream can simplify the problem

"
Class {
	#name : #FlattenArray2,
	#superclass : #Object,
	#category : #'Exercise@FlattenArray-Solution2'
}

{ #category : #exercism }
FlattenArray2 >> flattenArray: aCollection [ 
	  |stream|
	
      stream := NilFilteredWriteStream on: OrderedCollection new.
      aCollection flattenOn: stream.

      ^ stream contents asArray
	
]
