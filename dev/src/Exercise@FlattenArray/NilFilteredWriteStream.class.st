"
A WriteStream that filters out nil values on write
"
Class {
	#name : 'NilFilteredWriteStream',
	#superclass : 'WriteStream',
	#category : 'Exercise@FlattenArray-Solution2',
	#package : 'Exercise@FlattenArray',
	#tag : 'Solution2'
}

{ #category : 'accessing' }
NilFilteredWriteStream >> nextPut: anObject [
    anObject ifNotNil: [ super nextPut: anObject ]

]
